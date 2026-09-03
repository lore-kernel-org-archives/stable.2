Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707BC4A3D35;
	Thu,  3 Sep 2026 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788456094; cv=none; b=JW1368fXONYYuyTsykOoxamCIACyrq6BJufAtj0H/x5M0cO2xm9qXQax9Y6UYDbsWA4r7bd+Oacn9pHvjEM7S7+TCUXl0wHH+9n74Rv7uN65BEh9IcapmizLgcnPFWsb4L6opnjfgqwrBCE/jaiJUmvgYbMKYIzuzfnkxRCVO+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788456094; c=relaxed/simple;
	bh=8fLMl2i76QBah764wmDwdNZ3MjXBEOTxUjwIrnRm3ZQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OhlOcxpmLK7Kgz8p2KFs3LygWa+O0bsaLuSj0j0jwwrWUi2aQZm9zcA+uTTqs9Ax9CMygFXQfoClvHmqPcLpDC4lkJyd8Ufln0r1qvuK+13lmtbxv2k9vlwqdAJCk4vZy18Zv1FvWTiCsBAwFPbQvOC9R0gE92RpKZhTXjUwiaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MIp12bdW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MIp12bdW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7007C1F00A3D;
	Thu,  3 Sep 2026 17:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1788456092;
	bh=uofprPFCPxfEf69MnbeHxACRkACv1OeYBLcQOB9jELU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MIp12bdWHSMU1GrCwa+hfnX1qpV2W3u66ysoCVszd5rb+R79OlF5hj7b+DQN2bazx
	 eh1MiE9BwStxsnUVkLn6Qwj+C+HT9h+oDHRs+YbMfBdIH7L9CU8kBn95iYGllk36Ac
	 cfEtMHoLdsrMHgqb734Gi8d2inYB+SVJC68ZZm1A=
Date: Thu, 3 Sep 2026 10:21:30 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Kiryl Shutsemau <kas@kernel.org>, Vernon Yang <vernon2gm@gmail.com>,
 rick.p.edgecombe@intel.com, tglx@kernel.org, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, david@kernel.org, hpa@zytor.com,
 rmclure@linux.ibm.com, andrew+kernel@donnellan.id.au,
 pasha.tatashin@soleen.com, tj@kernel.org, rppt@kernel.org,
 yu-cheng.yu@intel.com, orsonpeters@gmail.com, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-mm@kvack.org, Vernon Yang <yanglincheng@kylinos.cn>,
 stable@vger.kernel.org
Subject: Re: [PATCH] x86/mm: Fix pmd_modify() dropping the dirty bit
Message-Id: <20260903102130.b5cda1b08f3efd4ab66226e9@linux-foundation.org>
In-Reply-To: <314f11c1-ce5e-4b36-b296-0ab742550851@intel.com>
References: <20260903031608.1194238-1-vernon2gm@gmail.com>
	<aplfcTfjeQUgnrvH@thinkstation>
	<314f11c1-ce5e-4b36-b296-0ab742550851@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 3 Sep 2026 07:18:54 -0700 Dave Hansen <dave.hansen@intel.com> wrote:

> On 9/3/26 04:54, Kiryl Shutsemau wrote:
> >> Closes: https://lore.kernel.org/r/CAJxLxMUGu1-L+O_nAONOwOXnS=cNbNApCWqdthRjd76LThtSPg@mail.gmail.com/
> >> Fixes: bb3aadf7d446 ("x86/mm: Start actually marking _PAGE_SAVED_DIRTY")
> > Hm. I don't understand why would this commit explicitly exclude
> > _PAGE_DIRTY from the mask:
> > 
> > -       val &= _HPAGE_CHG_MASK;
> > +       val &= (_HPAGE_CHG_MASK & ~_PAGE_DIRTY);
> > 
> > Rick, could you comment? It doesn't look like a typo.
> 
> My guess is that it's some remnant from an earlier version of the patch.
> The asymmetry with pte_modify() vs. pmd_modify() just can't be explained
> any other way. It _might_ have been some attempt to say, "Hey
> _PAGE_DIRTY is now a part of the pgprot_t since it's part of the
> 'permissions' of a shadow stack PTE" that got abandoned.
> 
> But I don't see anything wrong with the fix at all.
> 
> It does give me pause that this has been losing user data for so long,
> but it must just be a weird combination of features that few folks use
> together (huge pages + MADV_FREE).
> 

And with heavy reclaim pressure.
