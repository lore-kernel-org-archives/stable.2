Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4703C397E9E;
	Wed,  2 Sep 2026 06:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788332049; cv=none; b=BN/3VR1PqDhr8UpBsQU3R7xEiIXdSyTdvYyQKLwATtyPwMgBZ718bgit5h7Hvwv6Nqbb/Owj0cmTb91MiGTwYzoDL4SzNJqKiJG1YvHxcPeOrN0ckC/NtGIKdRO5hgmNFWsPGEwgpMY6H9o724f2uCuqdA2AhhTrgb+FJTzM/04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788332049; c=relaxed/simple;
	bh=VQ0eMR09Z44rRTjhL5rhLDJ5l7OqiRvUQqkFVpdTYwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bu4w7sam07EO14z/S3DupGE5tk3XC6FEjW8SDrFF3JECDNd2XLJsfM3cadc/P42xdhHmhIODnzLq4NFmoS5jI7P87wHcNFyGtQyOMmHXtncPfT29eo/k2AncA7PLEzcTn15O1E+8c4IxtscO/hXwlSncwKyqf5fIgCN5LEjxyi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9LXlRMy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9LXlRMy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97EDB1F000E9;
	Wed,  2 Sep 2026 06:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788332040;
	bh=VQ0eMR09Z44rRTjhL5rhLDJ5l7OqiRvUQqkFVpdTYwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E9LXlRMy71QVsY8sheYYu8i0a0kwSmb5sUNJXbYPUm4PGcSTJe0EFpbtAZtcBfBVk
	 DrBcSsbU2hZO2AJ5WOAT7mrNq3i+aOTLs0WppSZxOU6qoccgo9qmDEPkP5hNgKE88w
	 +o6s3ejY9UeypD4hLWWIY/kdxSg0mIjButD6P2uwVy2BpMnxGB3V+SiUNEwEM17omz
	 AF6cNdAjhcXBoRZrYLNWMKVFBENekng15BB+6Q41Co9k+VffBKpSLD1T4L52hJjDSr
	 0wfzAJBTRG4AZk8rCUxK3QwBNDU0scvnKtFCsgzHPm1rQGS/HbNhsZVGIzNETq4rio
	 DMwW3Y0kiKuww==
Date: Wed, 2 Sep 2026 07:53:53 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, 
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	Will Deacon <will@kernel.org>, David Carlier <devnexen@gmail.com>, 
	Atish Patra <atishp@meta.com>, Nikunj A Dadhania <nikunj@amd.com>, stable@vger.kernel.org, 
	x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/mm/pat: Acquire init_mm write lock on
 collapse to avoid UAF
Message-ID: <apfHa6QBI4Fjz2Gn@gremlin>
References: <20260813-cpa-fixes-v2-1-39b4ff90f91d@kernel.org>
 <178821524784.3717435.3293914321834699913.tip-bot2@tip-bot2>
 <b2095df8-9991-4e65-9890-c34f8c206319@kernel.org>
 <apZ52DKlJIrpX6qq@gremlin>
 <7fe0aee9-d1e9-419c-9ca6-c0160223d5dc@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fe0aee9-d1e9-419c-9ca6-c0160223d5dc@intel.com>

On Tue, Sep 01, 2026 at 04:36:38PM -0700, Dave Hansen wrote:
> On 9/1/26 00:10, Lorenzo Stoakes (ARM) wrote:
> > Dave - you've somehow applied this patch completely incorrectly to x86/urgent,
> > I'm not happy with this going to Linus in this form :/
>
> Me neither, btw.

Yeah, sorry to complain so loudly, but just obviously want to make sure these
are sorted correctly!

>
> So, here it is applied:
>
> > https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git/log/?h=cpa1
>
> The diffstat exactly matches the mbox that I sucked in. I'm going to
> launch some tests overnight.

Thanks!

I had a look through and all LGTM :)

>
> The only things I really munged were a little merge issue with patch 1,
> a SoB ordering issue in patch 3, and a few scattered rewordings in the
> commit messages.

That's all good of course!

>
> Not pushed to x86/urgent, yet.

Ack, understood that you want to beat them about a bit with some tests, let me
know if there's anything else you need on these!

--
Cheers, Lorenzo
