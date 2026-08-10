Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5516B43F091
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 19:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390276; cv=none; b=YCHm6m7k4DMxRzzD7AykKTHwyu0UnPwlP/1EU4ceheR4pCqeZslRg8npqBXhFHW1UrrClorvUWymjdSOLtgdNezhKWnzYaM6dABAjsCyA6UJGKyWXec9Q6AqyIufvIGdI5KEj8b9PBVSDJU8Te8EZ/kJ3jgCWxBTMydywJZj4hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390276; c=relaxed/simple;
	bh=iN7kNgwLgKJiuFQjXdKf24aC67oxfjY/MDB84bwnoH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=erqAfs2qYYOJreZs6LnSb9yn+uDgYdb117uYgbfT/cP6X9p7xugpHSHAUXKqZ26LfeeZKgtHVPUpoTv8f6B3eDKtXDov9ViWUhGm2ea/xSy8T71ViejJwar4Btf2YnYsoWdD9jL8Z/PGVlhXP66kr2NTx1qzvK4CcqfoUyMp5CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E80YFeoL; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E80YFeoL"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c20363107f4so238129366b.2
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 12:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786390272; x=1786995072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cPXRarnAO1rxE2tnGzCY8f31rq9Ep14HorPF8zSq0IU=;
        b=E80YFeoLZk2EUiXc4jsE1SrplqkL28YEVs8waB6M/n86BFkOCNtijGljnVdTSyBjgd
         BBki9XoYZpvYKmGTKRNALF75AepJx9ST7ATeF6LwlDug2ca21VrEXlaF0ySnPz9UIdwp
         io3nwv2Gu0MeF7kAFN4hwW7gUtrwbOvPlJtn+hmAOmINeW4miyg+oY80wwawWCSLqUuJ
         Q39I6RfciWTSoZt8XvTHa55xSmNYHLACUOajgzmNm0BB02oZoJbpRz2woV56/1WyNFKm
         cLM+PPKyBm+sx5a9PNfNQmlsk3Z9EGQjq72OpBiutB7tHZS7a14MT7HGiGXZ7rQP+P5W
         VS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786390272; x=1786995072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cPXRarnAO1rxE2tnGzCY8f31rq9Ep14HorPF8zSq0IU=;
        b=Beni+uMH4jc+A6PKmn1T/PBqBn1wbjhGd/ieDhw34BWomgGb/jmJ/JyD+M2w7LPJH8
         yVE3zYXnPNlkXc9+4VxAhHn4BCOVzmHSszCaYNeBEaGKiijDklu80OmwFBWTlSmov1Lb
         52+4hwsJoGWYN5jFVZa6PJyYclXsmL560TVKX5HfEPBhDFQDyqPZ2+GbGxAfLY6aR443
         YswohBBvm3PmwApoIA1yBUZHx7TpTkOd31/f3/N/BrlDPxxW2vEVaionetE2ICkzZ25r
         xKhnqjHmY2L9uoQ13gTOj1FMAWgd5lBdhiwiZM3bXU85d12eodkpqhgvM+KLGeoTBM1h
         1oqQ==
X-Gm-Message-State: AOJu0Yybew/THdRbo5L/vf88NZLzAzfxbZeHtczAb5ghzCUCvsVnXl9E
	TJMmsGsi5gqvDPUZQPf/nAJizoMfSZaG27yA5wbKvMzeJ3WdQkjt82x8
X-Gm-Gg: AR+sD11moUzR3bSqbKtW7whJ4oLm/FJxHL+TrcgCbb1BNA0TPoJuPoj5wcMMauV1FG8
	KIeEsD+fAUPVGsez96s5h23K3QjUT0J9vTZL24z1m4OYkVjdKb2CvshzjS6Ms/eiRuvJT8LUGPa
	a6UTbvKsEGOvWCZ2iYfAOyNV7iKGyeTkhDCrkO2+7rBysKHFMuE7DQFpW8RFMc/CaY3oIP3eYQP
	2NONE2+9YbtHutC/HytEf93oQyHJ6WbqHY40chfce2JAyJdELNteMnVmnq8EdVwlXB895tSJ7NV
	Ie2gJLnNdPFxk8LlL/4oXnzm5i00vYV/b7/h5D5WilBtZs9VKy9w/l/nHwSM7gnzA3ZQdEF8hgX
	jnhj7Qq/QxFHS/22kGUJT1L9I6C7cDvHe+lZ6dpbtMoA1ddw7kfoQQ5qgAgd9vDpgu23CURw6W2
	UYorXlrcxd31uEcXaPRRS0Cw2p5y1Qe4ndFOI1suTqeGHKVa3IsyyJSK5kalfso9MZE8ZPg0zZ5
	1wumK3kLignO7Hq3bw8MIK2xVZbvkg=
X-Received: by 2002:a17:907:d08:b0:c12:1651:17b2 with SMTP id a640c23a62f3a-c20c68f4008mr238800266b.9.1786390272284;
        Mon, 10 Aug 2026 12:31:12 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a1f4df3165sm3665532a12.10.2026.08.10.12.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 12:31:11 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: linmag7@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH 4/7] alpha: invalidate the local context in flush_tlb_page()
Date: Mon, 10 Aug 2026 21:24:48 +0200
Message-ID: <20260810193055.3286239-5-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810193055.3286239-1-linmag7@gmail.com>
References: <20260810193055.3286239-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the target mm is not current, flush_tlb_page() does nothing locally,
and smp_call_function() reaches only the other CPUs. This CPU may still
hold translations for the mm and can later reuse the old ASN together with
them.

Add the missing else branch. flush_tlb_other() clears mm->context[cpu] so
a fresh ASN is taken at the next switch. With the previous patch this also
covers a lazily borrowed mm, which no longer takes the targeted path.

The uniprocessor implementations of flush_tlb_mm() and
flush_icache_user_page() in asm/tlbflush.h and asm/cacheflush.h already
contain exactly this branch.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/kernel/smp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/alpha/kernel/smp.c b/arch/alpha/kernel/smp.c
index 7856d23b3384..a5a42ae4a7d8 100644
--- a/arch/alpha/kernel/smp.c
+++ b/arch/alpha/kernel/smp.c
@@ -698,6 +698,9 @@ flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
 			preempt_enable();
 			return;
 		}
+	} else {
+		/* smp_call_function() does not call back into this CPU.  */
+		flush_tlb_other(mm);
 	}
 
 	data.vma = vma;
-- 
2.53.0

