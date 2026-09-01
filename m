Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BD44457A4;
	Tue,  1 Sep 2026 07:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788247335; cv=none; b=ZelYVtA0gQGcITE2D4uAtmW3xzycj5LXM5YO8Es++alt7tbCXSEw+vgMEv85qStJQ9EiS60QSc8ypP/MaYTYr3crupfBjybHGskLY0pXq5CAJNHYFiz5NzStVZ1v8a1+pprig60Fi2pMQoORYN7g2BF/E0INpecbi1DdOF11IZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788247335; c=relaxed/simple;
	bh=ZyOG/BII3RA1IUKMYFm+LzIpwhwdrG9Nqt5WaqkO4yE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XsHgeap4RVPq2Oxs8An69iGcENE1xC/KVFLzQHeTgMwP4ihzIfTN5Xlt9KixPDbKon5r9GikKAPzMRKoLSMe/stODE/WbtvVARu/ZOWJ3sVZ6YJ5aehfV925PjjAC9Py/Tbq4RvewIFufUf6zxIBEBkFI27eUeyOrKN8LgppNDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmnFPZa3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmnFPZa3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BB21F000E9;
	Tue,  1 Sep 2026 07:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788247333;
	bh=AqO8A5cXsqIPIy+AgwxG/HumRP7s6/uiG2nuRBBsAeU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LmnFPZa3NfELUlN45TfAIRETmArwpc8ONbotfiCvP5E6Gs0SFx3MAWAnQdwFSeehb
	 76ftp/cLY58bJU0B0/3JgFNpuNWUh6Syz2VGzZCFCLeh4hze+iziJPaqAWcuhqAKTA
	 p17KPNlw4OXkelArOW3Pf500Tb4arFXpu8SP9RJVJCq8Fnlidr3Bpsgwyj8BRB0z15
	 xQybCg8R6pH3WERGuPXAIkDsr46Rt0STiXI62shwl6/NBUULzX6L0qLHY4exn7Ccjj
	 T5lXbT8JeMkY5mgCNRMDlUklO59gyc+8KXHxtgq30VmAfn/BAv+eTpAkP1+utomO97
	 GFq5mA3sOwJvA==
Message-ID: <386cbf7e-1734-4b56-ab7c-711d4f8ca48e@kernel.org>
Date: Tue, 1 Sep 2026 09:22:09 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: x86/urgent] x86/alternative: Exclude text poking against
 change_page_attr()
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
 Steffen Dirkwinkel <lists@steffen.cc>, Pedro Falcato <pfalcato@suse.de>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, Atish Patra <atishp@meta.com>,
 Nikunj A Dadhania <nikunj@amd.com>, stable@vger.kernel.org, x86@kernel.org
References: <20260813-cpa-fixes-v2-3-39b4ff90f91d@kernel.org>
 <178821524520.3717435.12731475498671524229.tip-bot2@tip-bot2>
 <4201eac9-297b-4672-8e7f-62e99dd13eb8@kernel.org> <apZ8AXqJBeI2BztN@gremlin>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <apZ8AXqJBeI2BztN@gremlin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01. 09. 26, 9:18, Lorenzo Stoakes (ARM) wrote:
> On Tue, Sep 01, 2026 at 08:16:28AM +0200, Jiri Slaby wrote:
>> On 01. 09. 26, 0:27, tip-bot2 for Pedro Falcato wrote:
>>> The following commit has been merged into the x86/urgent branch of tip:
>>>
>>> Commit-ID:     1c4d1c070d734b241728378c0f79950c23a10883
>>> Gitweb:        https://git.kernel.org/tip/1c4d1c070d734b241728378c0f79950c23a10883
>>
>> Was it dropped in the meantime? Gitweb says:
>> Object 1c4d1c070d734b241728378c0f79950c23a10883 is not reachable from any
>> reference in this repository
>>
>> $ git rev-parse tip/x86/urgent
>> 477cf5cd1f698053df7426b7b8d9339e85e00946
>> $ git branch -r --contains 1c4d1c070d734b241728378c0f79950c23a10883
>> $
>>
>> Despite I managed to download it at some point though:
>> $ git show --oneline -s 1c4d1c070d734b241728378c0f79950c23a10883
>> 1c4d1c070d73 x86/alternative: Exclude text poking against change_page_attr()
>>
>> What's going on with tip today?
> 
> Yup, I can't see this commit _at all_ in x86/urgent. Something's very
> broken here.

FTR, I dug out the logs:
  + 096edb090797...4a0e6473921a master     -> tip/master  (forced update)
  + 096edb090797...4a0e6473921a tip/urgent -> tip/tip/urgent  (forced 
update)
  + 34cd1c931a36...477cf5cd1f69 x86/urgent -> tip/x86/urgent  (forced 
update)

The original x86/urgent's HEAD (34cd1c931a36) indeed contains the commit 
(1c4d1c070d7).

>>> Author:        Pedro Falcato <pfalcato@suse.de>
>>> AuthorDate:    Thu, 13 Aug 2026 12:01:26 +03:00
>>> Committer:     Dave Hansen <dave.hansen@linux.intel.com>
>>> CommitterDate: Mon, 31 Aug 2026 15:17:35 -07:00
>>>
>>> x86/alternative: Exclude text poking against change_page_attr()
>> thanks,
>> --
>> js
>> suse labs
> 
> --
> Cheers, Lorenzo


-- 
js
suse labs
