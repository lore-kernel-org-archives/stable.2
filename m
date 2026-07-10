Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C863B9D81;
	Fri, 10 Jul 2026 21:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718687; cv=none; b=Gkvrn2swW5Klnu9nsgtItE45canXUKMRiuo41/E13m12U4Wt8i4Tfxs0OyeVjfTQ7OmKdrz38ZQmUYH6OLW2iDNrlqTWm1qS+OustYSOSvI+TS/jIS6qxAHJMxXGTxqAuPF5OxjJh85dWpR27h9DFtEP1EIMYl5z77Gvw6XxyVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718687; c=relaxed/simple;
	bh=m+R3rfBuKm/sWE7rZbLoet4PvT3ZU/1UnJWztjKmWZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4uyUtXButUieghpQ1z0l3ypqOReyWAYoB91zsCYAOk9QUOwvrWLM0gynuX2Qvdz+hTW5KW93LpXJ79FxZi3ZB42r1R6OUdxWvXvuyqxHxwpdQCcXeejUtrZd+subVEw+0HqZt7miuQ/TGduFtUs/AnZ8DTiC8A8BlMOxYQi5q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPy125+2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPy125+2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C044C1F000E9;
	Fri, 10 Jul 2026 21:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783718685;
	bh=JWd8LCIZnkesXCfOICmvUF9d1drT5EbNStlCv6sB1eY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NPy125+2CHeiZuVnIqZvuG98HsPvPc0k5jviRa8bZYP5sAtje+tqCrQQR5mlPMoTk
	 pvsJYCV/kjfsFUydRHxRiy+38eWwWASQlppviNc4eHXLa8dvfvDVCtFVJuJ3/vxL6T
	 9nIfKEAlG2YKmSNwCDHSI8B6anUzMMDs1wcLtfChSv+/Z+64+KZOp2zD4aG7iT+gCM
	 uK1loZ7AjVQtm1N4UuniVVXjbeV0MPGF+UewC8KO5ORHqclOFzz62q79Qv8wAy6Gdu
	 wuwRosJuHb7SNGeWvUCEKEyqSZL+Tx97A1h2G2c+i75B+C0uQGdMVtgep4Y4A7g75p
	 Z2ptxcfcx1FXg==
Date: Fri, 10 Jul 2026 17:24:43 -0400
From: Sasha Levin <sashal@kernel.org>
To: Kenta Akagi <k@mgml.me>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	stable@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 5.15.y v2 0/8] KVM: fixes for CVE-2026-46113 and related
 issues
Message-ID: <alFjG3TyQo4uiB70@laps>
References: <stable-reply-item009-kvm-515-20260627162226@kernel.org>
 <0106019f4a95a94b-890f7204-aef4-451b-b01e-14aa58b7a554-000000@ap-northeast-1.amazonses.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <0106019f4a95a94b-890f7204-aef4-451b-b01e-14aa58b7a554-000000@ap-northeast-1.amazonses.com>

On Fri, Jul 10, 2026 at 05:52:30AM +0000, Kenta Akagi wrote:
>On 2026/06/28 1:35, Sasha Levin wrote:
>> On Fri, 26 Jun 2026 19:46 +0200, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>> [PATCH 5.15.y v2 0/8] KVM: fixes for CVE-2026-46113 and related issues
>>> Please apply this instead of v1, due to a missing line in the last patch.
>>
>> Queued the v2 series for 5.15.
>
>Hi Sasha,
>
>It looks like 5.15.211 (released on July 4th) does not include this patch
>series, and I don't see it in stable-queue/queue-5.15 either.
>
>stable-queue$ rg -l "KVM: x86: Fix shadow paging use-after-free due to unexpected role" | sort -V
>releases/6.1.177/kvm-x86-fix-shadow-paging-use-after-free-due-to-unex.patch
>releases/6.6.144/kvm-x86-fix-shadow-paging-use-after-free-due-to-unex.patch
>releases/6.12.95/kvm-x86-fix-shadow-paging-use-after-free-due-to-unex.patch
>releases/6.18.38/kvm-x86-fix-shadow-paging-use-after-free-due-to-unex.patch
>releases/7.1.3/kvm-x86-fix-shadow-paging-use-after-free-due-to-unex.patch
>
>Could you please take a look?

There were some issues found in this series, so we're waiting for a v2.

-- 
Thanks,
Sasha
