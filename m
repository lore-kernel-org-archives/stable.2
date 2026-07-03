Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1960833FE36
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 05:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783055151; cv=none; b=ZcTin8PE4uPLfZEEGKbX41FYMgqNnGG46jaSZo0ZFfNhwmeJjD1R/plf/SeI1oX+KKy1GdoE4AqmumFmWoWK6BvS0k9Q/TJPNBZCn2FkIi8OoHXhW0Cw3s31e/PBBsyto6WoAqG+altQxiI3oiLQhEHboCXEXd+aEExUR23i1tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783055151; c=relaxed/simple;
	bh=3Au1U27iZcl4pVADshRVmDztN7WWYD7I9Gdi0ioXFro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xm12Z81ub/vausNNQtJubnf0ubJKUxRzxj468BeYQhU4rFWvLoIn9UT00l/W662JdIQpPusyiMUxsjM1dvd0CVrHVng6KC8BnrzBD02lkCINSmWwDFyd5b8diQUiYat4oRVmri7wQv3ddmEM3C2RCxT4JsQ1SRmi/PItKz6hr5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [192.168.0.103] (unknown [123.118.218.239])
	by APP-03 (Coremail) with SMTP id rQCowADn47oaQ0dqkGi+Fg--.1069S2;
	Fri, 03 Jul 2026 13:05:31 +0800 (CST)
Message-ID: <6c5c0723-66c6-4f9f-8021-2562efc95c6e@iscas.ac.cn>
Date: Fri, 3 Jul 2026 13:05:30 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.1 097/120] riscv: kfence: Call mark_new_valid_map() for
 kfence_unprotect()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Yanko Kaneti <yaneti@declera.com>,
 Paul Walmsley <pjw@kernel.org>
References: <20260702155112.964534952@linuxfoundation.org>
 <20260702155114.965608834@linuxfoundation.org>
Content-Language: en-US
From: Vivian Wang <wangruikang@iscas.ac.cn>
In-Reply-To: <20260702155114.965608834@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:rQCowADn47oaQ0dqkGi+Fg--.1069S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr18AFWUGFWDAF43ZFWxtFb_yoWfWFcEga
	40van5WryxWa1v9F1ayFsa9r48Kr9YqrW5X3s3tr4UGr43WrZ8uF1v9FsxZ3W2grZxKrs2
	ywn2qayxXr12gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb7AYjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
	w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k2
	0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
	8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41l
	IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
	AIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8KLvtUUUUU==
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

On 7/3/26 00:21, Greg Kroah-Hartman wrote:

> 7.1-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> From: Vivian Wang <wangruikang@iscas.ac.cn>
>
> commit 8d6c8c40e733b3fcaf92fed0a078bba2f6941a3b upstream.
> [...]
>
> --- a/arch/riscv/include/asm/kfence.h
> +++ b/arch/riscv/include/asm/kfence.h
>
> [...]
>
> -	if (protect)
> +	if (protect) {
>  		set_pte(pte, __pte(pte_val(ptep_get(pte)) & ~_PAGE_PRESENT));
> -	else
> +	} else {
>  		set_pte(pte, __pte(pte_val(ptep_get(pte)) | _PAGE_PRESENT));
> +		mark_new_valid_map();

Please also backport this commit's parent, the introduction of
mark_new_valid_map():

    9ee25d0a70ff4494b4e1d266b962d0a574ef318a ("riscv: mm: Extract helper mark_new_valid_map()")

before this patch.

IIUC this is needed on 6.12.y, 6.18.y, 7.1.y.

Thanks,
Vivian "dramforever" Wang

