Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515737;
	b=lPxBKpP3QwjODknzvUn4Ie6TNycoh94O/E47xGzPnzkqzKDYXCQAvZVkzntLRrS13SDs
	 TE3pfm9f9SvXMElUu1LM65IYz5/k2l93LP7xFxdaiixZSW4ranlU92rMdBAHEqXdDG4Nt
	 BROSmsdGJUobg0oMaiglBYOtTyVKLkYGHF1WvC0rL2Flak7twqi1eOtCp3dRhiRsdE3kF
	 xHINyXIJBuhbx878JxRDZoafafFZygVXdJH6An/mCfRCMLzFLz886StwXQ9kFUk6POPDm
	 jFBsaNY+Lo+QFbZUr7FsSXFgXS36h4MFyr3pven49B1piBUtBtT7xfELXQCBPdfENAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515737;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=aPMTYh4jUlEtoFpU5uzoPaBjXb2XK1o9mX5qbW70kCk=;
	b=sSStJzU645rnlinYud/BoAYmN145eA0uL+Qf0dtLZOoRLg0JRQpjEQwlqjnewgYCusSz
	 lr1FcL5PU1pefMlvBGbNru6pqPEEh57bPHJrTXYbOfsqqfoCWos2r/DRm++V3eKpvnCap
	 yHPKOF6L3kpXYPYA+jLukYTTkzEbe2zI7oGH/O5p9pO9S/zNrvhCsHrqiAfuImISLznQE
	 Qedyhs6U+raY15Sy0M97aXEiUl92b/BMgyFmTDWKCzMBc9+EeXwXTjp05NzecP5vqmPWZ
	 itQ3l4ClWN644J2rx24RHCawUx+JcuSUb6LSHUw+D3rFCCpbOQOKCwO7q5mJSXVggIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jQU90UPx;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959F3606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 20:35:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 959F3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jQU90UPx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794515735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aPMTYh4jUlEtoFpU5uzoPaBjXb2XK1o9mX5qbW70kCk=;
	b=jQU90UPxzYpOyUNx9+mo8SnImNWxEs70ggtP/B0lpZ2X85LW3fxdx+oRHKHo4//VP3n1UE
	8Hpu8Ki0xe5TpFizJWgsp07xcd36OXv3Le7YmzE8p3DySSyH4pKbzP/DokH+ZwjvGW0cYn
	QV4Xe3ORzY7gGUgp3g2b+Pkh1fADuO4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-pZJoAVHoPbmVjZ58BEaK9g-1; Thu, 12 Nov 2026 15:35:34 -0500
X-MC-Unique: pZJoAVHoPbmVjZ58BEaK9g-1
X-Mimecast-MFC-AGG-ID: pZJoAVHoPbmVjZ58BEaK9g_1794515734
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91eb556c8a0so4261726d6.2
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 12:35:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794515734; x=1795120534;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aPMTYh4jUlEtoFpU5uzoPaBjXb2XK1o9mX5qbW70kCk=;
        b=Vht8q/h6/J0rBYlsYXlSfXXNwNtDUuLeQ+0tjUsrX+Lznuyc+Op/K2vb7P8sOfFwfG
         khzpdxT5L5+uDFq6nCpqJW9xXI6fSS/TTw/Hwj1Z8hpNo7J4WqJASYiklNCRNF87K155
         +Ly744zRn+rVrMm5NSy/CD65YTkAx2jdue4utYkLLzRpu3xiPhTtlOQmRpye0ORNgWsh
         HAr2M55Hgk3Z0N69eur7HWvgE23ErD/gly4XdrjMQC3qKbB6ta0sLLUatZKgLl5uIG9r
         KzpYHKAK3hL4e+GNYYibucQyUqFc8x7PFMp1uXBmiu7Lo94k+9uvZZuy3PC4Xr8tzmu8
         7FFA==
X-Forwarded-Encrypted: i=1; AL+hErH+Z3ris+fc5CS5g5M6BUUwSwhZJmSll9aa2W4JVzl3+/WDBSelTZkoGdjFAUj/Zv9sqMiPzCE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Z2L/miXQpywFBRTZUl4B9BwCGcrA5EDWqRDIY5SQhqUO14fG3
	DhVFTYwd12JF3ftIK1q/pjAbI9czEr6q2wgiaYt8cD98IMYwlkaW+wq2BvjYEwSaDktgZBWzG4Z
	Aub/t8r0zX0g57k35nQvLn7pVgtlOuS9cgwU+IcA7gPWYygxJ3L+Y662AWA==
X-Gm-Gg: AYBFou0+qm90iR1ljWX6kBG4yOllugLdiD9o5sX3XD5dq1Rg3SElHFFLKngfAFoUUE4
	1x2bnygqzB7929q/UDsyKrIUndC2XpQE75bqADa1Rh8/tFq69+pf0Uzye7Gy2Cwb7dVb5XAnc4D
	zOg+zwZmidUu5cua1RITz+QOQF1los/L/28h+W3vYPxCd2buhyOMa/5Yd00Red4AqpKw6O/3iou
	DOmqcnZc8DIpu6dqiGJV5UnvC7fBy/I+G1QsEf176rO71mAU0Qoa9PmZZw6D5hRM+fD5JFv21t2
	leXjfPtOSsLZPTa3QBzo/JtLoKrAxHOFZncXM3jxB9ZAGjIsYgfkMzSQj/2/w0P0wJQ6o62csrR
	rfg/7PvZtxTgob7ShMLf2mlR2tQKN+a0MgwPurGyasb6wIPCc0cD06fgMdmaxTpfPagwXdmQJum
	flkZ+sGoOEVFIL0si4ulWtt83sUvBLii7qlZRBGqxOIw==
X-Received: by 2002:a05:6214:2265:b0:917:8b9f:d62 with SMTP id 6a1803df08f44-91f2412d3a0mr8231896d6.18.1794515733334;
        Thu, 12 Nov 2026 12:35:33 -0800 (PST)
X-Received: by 2002:a05:6214:2265:b0:917:8b9f:d62 with SMTP id 6a1803df08f44-91f2412d3a0mr8230626d6.18.1794515731987;
        Thu, 12 Nov 2026 12:35:31 -0800 (PST)
Received: from [192.168.2.110] (bras-base-aylmpq0107w-grc-07-174-93-165-160.dsl.bell.ca. [174.93.165.160])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23d456b2sm4369966d6.12.2026.11.12.12.35.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 12:35:31 -0800 (PST)
Message-ID: <7887e5c4-b86c-4144-b361-8d4a377c6acc@redhat.com>
Date: Thu, 12 Nov 2026 15:35:31 -0500
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1.y] mm/vma: fix expansion of VMA_MIXEDMAP_BIT VMAs
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Pedro Falcato <pfalcato@suse.de>, "Liam R. Howlett" <liam@infradead.org>,
 Jann Horn <jannh@google.com>, =?UTF-8?Q?Jakub_Mat=C4=9Bna?=
 <matenajakub@gmail.com>
References: <20261109201653-failed-6.1-8146c6478224@kernel.org>
 <20261112035912.1673036-1-sashal@kernel.org>
Content-Language: en-US
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <20261112035912.1673036-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/11/26 10:59 PM, Sasha Levin wrote:
> From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
> 
> [ Upstream commit 8146c6478224d8f6395c6b08a19c344a56d79867 ]
> 
> Commit ca3d76b0aa80 ("mm: add merging after mremap resize") combined
> merging with expansion of mremap()'d VMAs, however it also unintentionally
> disallowed the expansion of unmergeable VMAs.
> 
> Previously it was possible to expand a mixed mapping which mremap() had
> already ensured was a legal expansion.
> 
> This is clearly seen in the mremap() logic, as it checks
> vma_is_fixed_mapping() to determine legality of an expansion rather than
> vma_can_merge().
> 
> Additionally, copy_vma() allows for a failed merge to result in a new VMA
> being instantiated if MREMAP_MAYMOVE is specified.
> 
> However, this is not attempted, as a failure in vma_merge_extend() is
> assumed to be an -ENOMEM failure.
> 
> Since vma_merge_extend() is used exclusively by mremap() to perform a merge
> and/or expansion, resolve the issue by invoking vma_expand() for
> unmergeable VMAs there.
> 
> Explicitly assert that the VMA is both non-fixed and a mixed mapping.
> This provides double insurance against broken changes in future.
> 
> Note that khugepaged_enter_vma() (which vma_merge_new_range() runs) is
> redundant in this case, as a mixed mapping is not subject to khugepaged.
> 
> Also update the VMA userland tests to add a required predicate.
> 
> Link: https://lore.kernel.org/20261023-vma-expansion-fix-v1-1-6142baf1f46b@kernel.org
> Fixes: ca3d76b0aa80 ("mm: add merging after mremap resize")
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Reported-by: Luiz Capitulino <luizcap@redhat.com>
> Closes: https://lore.kernel.org/all/20261023023106.515365-1-luizcap@redhat.com/
> Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> Cc: Liam R. Howlett <liam@infradead.org>
> Cc: Jann Horn <jannh@google.com>
> Cc: Jakub Matěna <matenajakub@gmail.com>
> Cc: <stable@vger.kernel.org>
> [ sashal: adapted VMA expansion to use the existing vma_adjust() path instead of vma_expand() ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>

I tested this against the in-tree reproducer and ran the MM kselftests
(which I had to hack to build). All is good:

Tested-by: Luiz Capitulino <luizcap@redhat.com>

> ---
>   mm/mremap.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/mremap.c b/mm/mremap.c
> index ec66e7be8afea..f7d9687d7735b 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -1098,8 +1098,12 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned long, old_len,
>   			 * expanding, so perform a simple expand for such vma.
>   			 * Ideally the check for close op should be only done
>   			 * when a vma would be actually removed due to a merge.
> +			 *
> +			 * Mixed mappings cannot be merged either, so they also
> +			 * need to be expanded directly.
>   			 */
> -			if (!vma->vm_ops || !vma->vm_ops->close) {
> +			if (!(vma->vm_flags & VM_MIXEDMAP) &&
> +			    (!vma->vm_ops || !vma->vm_ops->close)) {
>   				vma = vma_merge(mm, vma, extension_start, extension_end,
>   					vma->vm_flags, vma->anon_vma, vma->vm_file,
>   					extension_pgoff, vma_policy(vma),

