Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1949F3B058E
	for <stable@vger.kernel.org>; Fri, 25 Sep 2026 04:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790311061; cv=none; b=p73mDZk4++AUFLKkVWS7OocssLeTq7+hYpyYHknE8MAOm/JETsFubjCjTG21f/2Gn0pRQJYNE/81H8gp/hV+ASJP4IG1UaN1dVERjdFSHJMcZSYg47PaMNLxZ1HppbW4yH1M/IV8RpSqEirdTp8q9ywwTLkxECrbz4zHGpdUKRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790311061; c=relaxed/simple;
	bh=0w14uU0L9w0RSlhqe4EwjyDn82UdTnD62jvdVeDf4M4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BmIzgGmPP5Ob0JnuFWyblxta90+scrdLn03j/i0Inw13AE95dAJhwVezTVnxABoLwr0kpGAj+0s2a6ypK3ocKYBopi6Px+L+u1zHUiqTQobKS47cyo6PUE09OxfCFK2eFkJW8pHz79KfgG4P3rdbhdr+NzskYVDCfsqBxtmq99o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kaeaI3mA; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaeaI3mA"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4bdf8abaaso291587a12.2
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 21:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790311056; x=1790915856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G+A2Ge7yyIYJgtfX/fpz/xgx25zdYkH52+JvJO6nACg=;
        b=kaeaI3mAZKymGZcxNam+2NKedngnmH0yPYv7fgSPOxsV8adI8oQb83XupdT7so2DjW
         U1z4qbamrGEIlEVthoURC6SfVua6SgSJmaw8BOPdnCUS5NTOA3YWkG5ulX7hF1KHKrTC
         lpF/bF+9uVkuhCHBYdfPrxI0oyz3A2oGbRK2zeCIee1bM7jrVohuZabWOEh28b0FmmkO
         GoLxckTWwY3s5rZO4jLNz6yWu3PcqWp2IegZAaeiQ5FbMDlHHBmdpuT/FZL+osNquioz
         xJatnqNf8BGEdQprTAbURZrlLap9cjM584+Tz0VFMqr5h7/HURLE8OYEu1oIpBmNT0pI
         u94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790311056; x=1790915856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=G+A2Ge7yyIYJgtfX/fpz/xgx25zdYkH52+JvJO6nACg=;
        b=RSXA6ivibDsJQFz1tjcLbzJXjZhRdO8J5AnhJPT6IH+O1qu5oLhH3mP1svetVtl6Qq
         oIuqVJ4gtpCQ3phfrtcyDkomTpc0bCbQ8LuPvim3M/m2wplqMdhMHoH6X4trSJLTuEXY
         emELi8UgP0IYY8r2n9X6DmIY6w58nnJbHDrPcZYRdxT7klRFSPME9hAF1EnrwxaP7XXU
         oKyLY7fzHP/3TExTOAErb3AE5IR5i94kf9RFK+GXX0zlz+hkW3dunTPhAvEO5XTX8770
         St5PuDIe5Bj5PkGk4VE8J/A1vigAt0yJjhJ4cYe3jmaXaS3MVwbiG/Wk7wWwBq2YSIFV
         9SPQ==
X-Forwarded-Encrypted: i=1; AKwUvBzthAMKVsA+ER37PmKBYyHswtCDFZipEyU3oWTGa5nvQls+BK4yheDyhnMTTBHaOp2k/6LEUAE=@vger.kernel.org
X-Gm-Message-State: AFuF++meQjlqY9OUjCDQHpF2xBxYuZGFbDKztsIecv+Fyxefu7nBolO7
	e1jfa1UM92IQKJ4MNktnK7/MD8KVEgltulNqVjlGexsbMa8OORRJvS8=
X-Gm-Gg: AYBFou1l6AW2OHAKYN7yrFdc5+91VIbBuk58UvGc4eJTeZfpzk5riOvyv16UeueLphR
	bNqHoFtZ0hM3nWSk8SiSj7q+w1AmO/+oXiHGDSsZqo4CRr30z7FylJKjtMT4HoefuhMjHK7NcK3
	3dRaLFSJYfKPyYgaC5EMclwfO1uGp2VhjiFRbA4GzDAMrpQ9tOu+/hpn63Hc7OYWIvxnAxHaXi+
	fGVFxUVnyJKwvbOqajwcYQzGu9IAir+AWdDd81SVmYhMSQ4KOldymvkEP6+I59X3QidC2AZMZlh
	glsyoT82FDpYkeZEykKsFmu+IiudPrv4EhaasyPybscxOMo/QvreeQJUXN2wR47BhOJN6GZ2nWc
	K4iMFtr7avgxhkeEYXiGolEh/d8EG/arN8LqIVFpeI2BjpTUp6p1lQ1tCvyikvuCfYKAHpr7OkY
	bS1WUgjPYUvcHLXH8eLcvG6CJ14kitoHniFgU4NclQlRCnDdPxobvpKpnsdVx6Tq6NQY8Iq4eRe
	cpywIzVzAnraFi7myCfKuLs
X-Received: by 2002:a17:90b:3e82:b0:39e:6c68:c779 with SMTP id 98e67ed59e1d1-3a098e054bemr4230964a91.47.1790311056420;
        Thu, 24 Sep 2026 21:37:36 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([211.230.25.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9357f64sm2006727a91.3.2026.09.24.21.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 21:37:36 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	peterx@redhat.com,
	surenb@google.com,
	aarcange@redhat.com,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	mhocko@suse.com,
	shuah@kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] userfaultfd: clear the inherited uffd bit in move_swap_pte()
Date: Fri, 25 Sep 2026 13:37:29 +0900
Message-ID: <20260925043729.2362287-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <arO0a3CU_idyVsqQ@thinkstation>
References: <20260919004630.1159895-1-donggeunyoo.kernel@gmail.com> <20260919004630.1159895-2-donggeunyoo.kernel@gmail.com> <arO0a3CU_idyVsqQ@thinkstation>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Sep 23, 2026 at 12:18:30PM +0100, Kiryl Shutsemau wrote:
> Putting it in the 'else' is wrong. Clear uffd on the source
> unconditionally and re-arm based on the target VMA:
>
> 	orig_src_pte = pte_swp_clear_uffd(orig_src_pte);
> 	/* Re-arm RWP on the moved swap entry if dst_vma is RWP-registered. */
> 	if (userfaultfd_rwp(dst_vma))
> 		orig_src_pte = pte_swp_mkuffd(orig_src_pte);
>
> That is what move_pages_huge_pmd() does with clear_uffd_wp_pmd() before
> its own re-arm, and it is the logically correct way to do this: the
> source's state is gone, the destination decides.

Done in v2:
https://lore.kernel.org/all/20260925042907.2330519-1-donggeunyoo.kernel@gmail.com/

Thanks,
Donggeun
