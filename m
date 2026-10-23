Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792722686;
	b=iFLWnqHZU2hqMaJa24AeSBZkhTa2kP7j3RmPPs5+RvsHj4S9ibgBA2o+QUCQdUUML6Hg
	 onJ4a4rpanR9RR8QtCQabB51vLdoM5B3wL4+whMsCUUTp5PIMLAxUbkECRqvTaTT0cK7g
	 l1cfDiE901HlEy/GBSYt40WgIh6zsodoW0eGVcFK2WYgK2AHKfcY78S1Ko+jYMwlijDSg
	 sP5HgXGTP7AVBDNCMEfzTv5HxJFGhmuG295iEVWYlzG1QABeD5+rmDh47obdD2WFl7HLi
	 eOaMvRUXA30axd8hk+VtnLZi1R/3p46KhZpNeVhhCS4SnntniLMPjrZyrrbU82ChrZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792722686;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=TdC2YU/7lyTzZkxDhw5asx021VZsxqMU4X1jjnTodL8=;
	b=BLEYm8lUN8d4e2batqNr3/136tHt+H9lp0C5sfSrA5HvegrdHckrB2/x9DInbPiuJjgV
	 U4qoePteTTqyrHp3IFEX2fY4/GvG0F27N+f8k9vb2xO0IlSrTFEbDIggDojQYQIqLepme
	 aQRPL21EgTWX1202PbCaEIwtAGPp6he9HYyiNNKk+LVgynlCqLGcXuse3ImSIoZZBIFDw
	 44dDIPHVBUd9mQhMm9zzQEnhW9k6AdBOVQpJtm2Zb5gvlTSZEQ/mVXWzg8IetUMai7z86
	 zK3aWvvpl4avOSDLRr+ILaG86LiJgQJukGkND8rxZTPhlNBfYJDQqIR9L7sdduBvn8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k+LbJpp+;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3AD7606A31D
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 02:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3AD7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k+LbJpp+
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cd5c9e52398so163269a12.1
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 19:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792722685; x=1793327485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TdC2YU/7lyTzZkxDhw5asx021VZsxqMU4X1jjnTodL8=;
        b=k+LbJpp+2lF6brykMMSEFsfxbR1vyf49x+qykv07u1iRFSOQd9SlLr8vm82HGUsrrT
         QPInWkto4gnChu6CzZBRxhUSO7QZMSM6rgdhVve91aYe41kgnIcbSU9VMgupSzJ7Bayl
         Aou4YPXzRixuF6dJe4Nh/v9pCT4TuJzzvFW1D0oLbtKTPG08lunbReR5YH2uXW80N77H
         YVn9DzUyxATw3BMJZ8rSB34KTGF6xBDeTgtkYvYVy8tK2NA95TGaPvcoLE8saNRi+HWI
         0wogt+rraOjGFDrb5zRHX1vuq0HUUi71cIoUL0Z+feUvGUabFEn8RaPXiej051CJ0xBc
         cD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792722685; x=1793327485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TdC2YU/7lyTzZkxDhw5asx021VZsxqMU4X1jjnTodL8=;
        b=b0lRYF/nCjaWt6s2NN5Fc3lrYmDGMA6nWtbjH2eCurZtGxlGM6buCkLGZO7CpP1g0Y
         p4FSO0SGGtP1fTe4Ux6u5rPdDT1ngLDSNKFqU9tKDEa/av97lvhpSB8oKK2RUcL/Xb0R
         N21Rq8nUJx9I4LaY4XhbLLUXOJXds4QWTFhg/FWQfXlLczL5cr7OkKc3YGc/1guvl4Fk
         NZnf8QeyzwaZCxCQmUvdvUyxMLzgDKcEKJdzpDx+yGY1z1EZcyPifoCStT04dEdgeV56
         qeAQdxgmTBUaYN4JOk1048Lj8dociqyiDKp9/8fj5aecTLjwgKUqz1V5eLWlRKS/wJAV
         Jctg==
X-Forwarded-Encrypted: i=1; AKwUvBzmUevWMbUTc3PcA5JKoioKj+lQXffBhJ3UDI1iHjhERFAuUbGniuSChN2EWEIIVc0AAQMUiwk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIH79FW66bdGRW2ZiSY7bLtAetKPEcDfXQMo7B9I8p0/2dxpA4o
	72HcA+V3BM0d9s5iW50IJeq85Ka0r0Y34hcXaMGLOGu4qvy/+kwKavzlDrlId2a6U4Q=
X-Gm-Gg: AYBFou2vQrvkZhG4BIev9aXDaBUEKlImPboQ7m700tH4GFedSD5bCLNwtjJoO6N/iC1
	DMkJsJeMTLK7xt3xMTnJrfDhNu90TZHt1GNcwK7X2zjbhxNta5sbREQq7XmKs+HrdtvTa20Ilc9
	GBHoFKJRzckyPY9DXQA237jIPCqC7Hh5EBlCabBIzHMa8nsBvaQOV9fXsxRR0zFTJIe2lnc23Ks
	z5GZrnBgs99WduMsoGfRIzmLb6yPsCMXsosrCUx4Vpn6YzUHX5Sa8n/K1B85QuiLuihq7WvMXsx
	YgPgwILCONRbjhuJGtyr9aM2ZCmK2AkfNDXn2CeansOhn9t1LyIIabFll7HwP+54UVWWXCFWAiZ
	Cxk52oZKjbXo2ofHa/Vs595xJe7VeVOMZJ9aerwoL5JtNI4eCBDmqiYBRrUFWUf5a4ZenQI0tBL
	BhPKyH2pk6nQDTkVrAQh0FqQ1OoWOjomd7NfY2zi0VG7SN9KGAJJH3xXTDOIEU25OVi+txmOUfd
	QQN15naj5rJph+WfQ7+j+OiBJcMoBnZlZgPDuP0tP2FSx7qVUp5ipM0Roe5jOEZ4eR/2Cr5SbPC
	w3HG/zOp1i6GaWUxX9uyo9Kky5+XH6Eh0d4d1jERPRY8+S7/ZzCtb845V6W0xlH0xkCBjWLr
X-Received: by 2002:a05:6a21:70cb:b0:3e1:1eca:2214 with SMTP id adf61e73a8af0-3e37668ea73mr712556637.49.1792722685212;
        Thu, 22 Oct 2026 19:31:25 -0700 (PDT)
Received: from localhost.localdomain ([240e:46c:1d00:19d6:7438:ad54:9ef4:bc36])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ba89a40fsm279852a12.14.2026.10.22.19.31.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 22 Oct 2026 19:31:24 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	gourry@gourry.net,
	david@kernel.org,
	tim.c.chen@linux.intel.com,
	yu.c.chen@intel.com
Cc: linux-kernel@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] sched: fix stale get_pref_llc() stub for !CONFIG_SCHED_CACHE
Date: Fri, 23 Oct 2026 10:31:04 +0800
Message-ID: <20261023023105.28829-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261023023105.28829-1-laoar.shao@gmail.com>
References: <20261023023105.28829-1-laoar.shao@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit b636fef85bda ("sched/cache: Introduce task_struct->sched_cache_grp
to fix UAF") switched get_pref_llc() from taking a struct mm_struct * to
taking the task's struct sched_cache_group *, but only updated the
CONFIG_SCHED_CACHE definition and its caller: the stub in the
!CONFIG_SCHED_CACHE branch kept the old mm_struct parameter.

Fixes: b636fef85bda ("sched/cache: Introduce task_struct->sched_cache_grp to fix UAF")
Cc: <stable@vger.kernel.org> #v7.2.x
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Chen Yu <yu.c.chen@intel.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 57360f5cdde4..973647ad6c2d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2194,7 +2194,7 @@ void init_sched_mm(struct task_struct *p) { }
 static void task_tick_cache(struct rq *rq, struct task_struct *p) { }
 
 static inline int get_pref_llc(struct task_struct *p,
-			       struct mm_struct *mm)
+			       struct sched_cache_group *grp)
 {
 	return -1;
 }
-- 
2.52.0

