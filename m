Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54704908D9
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 14:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791642360; cv=none; b=OvfHRNWyN2zOIkrt4vweH6qCmJiVfAyFvbsaQApujXvDcblyKdalcNsPT03Ah59Q/wdRzMLq7ONgYald31Nus592FEjpd09LdmyAqY6Q11vk+K3eknlCeq1es1guS6YQiM0ywUGMsCWrtgtuIVm9kmZ/CloX3smXozKr90Wug4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791642360; c=relaxed/simple;
	bh=qhtwvGDBXxuz/27lCoFuaDbYtnj0oyQ6yLwPkWANBxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ipl4JwoCiDJQjjLv4B2nv6JZ74kS3dhBTCotJFBVd254bYkWcVSOFkKbA2PaWugfa+NnpZePWxqcj6yy2NL9E5P/rSJjAkEoN+UAMykEIX0j6rYd+IiVGu5m8DzmIiao1HS28yJ5Z8nH76CACgPpgBuaZp8bnSq2+SnQgW+qQAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bx79SBVY; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bx79SBVY"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b16824c0fcso728027a12.3
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 07:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791642357; x=1792247157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FCUBSVWptzcvT6OSxO9Zn5kkji5kybgcPd9DFV2WDWo=;
        b=bx79SBVYxk46ImVS2+jrJHpnkHjNXI8J0oSRBZKqHtwqPVbXkrM5eOKh3/XdtaLdGf
         nc3MhOGSW1TABmvQjCB+H+VKFQw6QSWittLASyHc3jYVuI4vY6ZPTJJ8RAjllvujtpKV
         jmfA4BRrS35tYNJa+4IWwVFT0Ww73TRK7nTk6hY1ZJwqPX3wH6+3DIkK6ncUhBtS0uHP
         /nK02LZUTQFNk0JW6tpmIKAsqY2tJWHyd34mmNjP2hfsfOynbIZIC+2KvOg8IjtQpza8
         o36QMeDYjRZurCXG9QIJWb3Bj2cG24jJznNKd/bCQp3mlj6m9BPENAW7kZuEQB5TR4U7
         YYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791642357; x=1792247157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FCUBSVWptzcvT6OSxO9Zn5kkji5kybgcPd9DFV2WDWo=;
        b=YBEiPz5XhBQ8SqEsU1w/tlmb/efvMDK9HrZTMaVBHfckb3qw4zsIyB75db361Y01C6
         ZSovYNhz4at8XkrN0WY7zCL2geTGVT9vob/pvZQxR092fNmDfplmDQgM3fWWzj/uyyGA
         Pj64Jc7sp29KRt0t5KyAwF8JAGnHdhJTQi5egSrFtZmEew9JJjeRRAEd8ohGu03eU0ex
         r/hhrpBVGQdjY7pM4KOcagie2aNS/v663SH6Ukp5CFS/35rTcaduNggICKtVMEvSPueQ
         1OeNeUSSN2H5OB94w7vMBTBN6JZRTR8zlafXb8qlo7Mj/J7zZcMWLgxKHcw9W1Ex/jdZ
         4L+Q==
X-Forwarded-Encrypted: i=1; AKwUvByr9zhkVf6htgUuIyd2O8EWZerLPpd4ku76Cc3ji8GqMxRrG1eW6D6UjoDAaH+PB3fAapTvrhc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLfgdjkLTcY7kBDBt8jlWLQyIMu3JVaorGLC9R3Sx17w+hUwVJ5
	8oancPw+Eug/r0Km9MNaWQTu/yKdr+e0Y7jfR41Xe4nNbOSoK/5UZwYdWl4FI5XJ
X-Gm-Gg: AYBFou2o4u7aC2EfRbtKpc4N6QKeybdOhvTiuoeU/NGKtDd8z4DUIFZjPgVpNOjq58S
	Oz651jvAh+b00WcwFAbL6JDbLRTIW4nUwI0FbO3Xv4KWOYWIudQOiYozLcrN43HPc4A6N1IhtgS
	+k3QbI3bJbBJPsIFdzkAHwl2HnbMWh2+s1/eTDjAyUzCAIHlUppcHtAK1gaVP9oppydAPKL3RqW
	qXyURRnDah+inCoDMGnguWQL+mk3LdCsCYMUyi/bkD10lEAV9Iiy3TEs7Dz/WkRBxJFi0/kua36
	7Z1c4px8h+rfZ69jSEMc870FlZjy1G487iDgme9CEpuXxs3208t41TUGdLkgUWBOJC04rbKoZxQ
	ifJgtBNpAHmywmZPTFkZO+zBFqiCR1L+ztffbNiW+zzZ2hWQTOOXTEF7cKPwakGsZmTS6lX3ymb
	KiG6aNpUMAHNHE97dE7FjuIlyj47fJWIPZ19kVdavvS/v8spsN/NyiyKSFOIWDJi+roq4+PE4c+
	l4L/Y2pV4zAOPPxKdQamHnG816GMx6tePXqSRue
X-Received: by 2002:a05:6402:4605:b0:6aa:f809:ef3f with SMTP id 4fb4d7f45d1cf-6b17c1dec27mr3805245a12.5.1791642356805;
        Sat, 10 Oct 2026 07:25:56 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b179dfff40sm2635586a12.34.2026.10.10.07.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 07:25:55 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: richard.henderson@linaro.org,
	mattst88@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Cc: linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v5 6/8] alpha: fix the local TLB invalidate in the UP flush_tlb_page()
Date: Sat, 10 Oct 2026 16:24:32 +0200
Message-ID: <20261010142533.974797-7-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261010142533.974797-1-linmag7@gmail.com>
References: <20261010142533.974797-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The uniprocessor flush_tlb_page() in asm/tlbflush.h has the same wrong
test as the SMP one: a targeted tbi() is only guaranteed to invalidate
the intended translations when the target mm's context is loaded, but
the gate is current->active_mm, which a lazily borrowed mm also
satisfies.

Test current->mm instead. The else branch it falls to already exists
here, so unlike the SMP side this is the whole fix.
arch/alpha/kernel/smp.c is not built with CONFIG_SMP=n, so this is how
the same defect reaches a uniprocessor, where the flusher kworker
necessarily shares the only CPU with the writer.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reviewed-by: Matt Turner <mattst88@gmail.com>
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/include/asm/tlbflush.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/alpha/include/asm/tlbflush.h b/arch/alpha/include/asm/tlbflush.h
index 0c8529997f54..9ae1902faf8e 100644
--- a/arch/alpha/include/asm/tlbflush.h
+++ b/arch/alpha/include/asm/tlbflush.h
@@ -87,7 +87,8 @@ flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 {
 	struct mm_struct *mm = vma->vm_mm;
 
-	if (mm == current->active_mm)
+	/* A targeted tbi() needs a thread of MM to be current.  */
+	if (mm == current->mm)
 		flush_tlb_current_page(mm, vma, addr);
 	else
 		flush_tlb_other(mm);
-- 
2.43.0

