Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794880485;
	b=qdDvRZrBgexp6hrJhFSRzZsYfj/vJBoHt8iHzoaG5vFQQfcVOmilapCxRDYONksKAlHu
	 7MxXUng4w+A4eXrD1VPercaqCKAaGafzh/FshzsbabaLsqyRnlsiv+fvmuf+o6+lq6OpQ
	 yn2THcBkg4wI/QI5SApxvDJXtc2C3s0rWvnH43JvwNSxa8snHWSyda5CnRukbHhBbiok5
	 Fe4u2mduLqg9MihLUzOTcZ7slD+b1sxDd7w+jEjyaHDXPjOBEJnqkAVJvq5eTJWvQ4bz/
	 N4NF+bt0Avf5NX31+Vqa2K65Cnk20cSbD0X3juI3/sJjcgDcT1RuEEXkie+aMPxBwuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794880485;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=elkgCBj7aFay/OU9BHM3KC6ZUvNspwV9FYqesvpWo0I=;
	b=h296CzbCV8UWVnQpX5VJBL+QHM/PXp3voNRDQ7nS6A6giwJgb8kdFcZ/rpYL45LgcJoM
	 m/8MaT2J358hI9PIMeQFV3W3BI3cIa7BQhyhCHb7ESaw+/KsZbkPtA4CqZjctpRcmHtoA
	 1SEyA9VFARK5LRq8+QAuyPulPJeaBHM35g9VjevMF3TP0R/J8oz+3resofSoQ5+tGTW2U
	 nLZZGyo5eeQrReAUmlTIzLd5ErQHEXxPdQEg7lA38ImJCP1Lj930TCKGKm31lcraij5zZ
	 XWPNa0kX8YviIztd4tjK9nD2Bml/4fDoxXiK5/UC501qttTalQ0zGFLiNddEzbhIb1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hIBv2MBd;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00BA606A32C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 01:54:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B00BA606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hIBv2MBd
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3719e3cb82bso447343eec.3
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 17:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794880484; x=1795485284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=elkgCBj7aFay/OU9BHM3KC6ZUvNspwV9FYqesvpWo0I=;
        b=hIBv2MBd2fvE4Vyu417yPTLhgJkc40FmC1Wfo8/CALgriSL3fwBkrdtox5K//HFBrV
         CWJWLcx9M5xKuerupLWV7hYNFfmn32P9nwEvjTqM8lT4WO+rxTlf+rXw6EmRsACvbW49
         z1rfEL7tp3z/eTwcQWdUx+rvencAzjXAaJgt45glo8joyDhHc4EzGg6SWhYgLSgIdeFZ
         0VFRNQnCYl2AJ0q/eZgaN5/R4xMhbtO2ioaFhiUichv2RFJlJtSTpQlZuKK0dtG25+My
         mScA4X0JmVwDgaSu0fcjTblhJ27H9Bb78LIEVc7wMHYoYiRTKdaRyqFunaVnvkySEFmp
         36Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794880484; x=1795485284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=elkgCBj7aFay/OU9BHM3KC6ZUvNspwV9FYqesvpWo0I=;
        b=H8xyNklZEEV0Ot+LcALwGZgx95PFeaIocbixcyOIvKIiq2YO/AgUNuQ61UE2WZ8lPj
         GzSW4z45RK0SN67hZS7mIerrUI/r2kJde6s3+9ky91KyLs7WlbbegUr3gkEo1Nuc8dTK
         MWq2AGPwtsyhZgVr3JJXUTlngzrHUaMffBckCDRQanZpT6UJA9Eu0Vw4abCY74YC7497
         AUV085XAJi+RhcY5iDbTZMKVSH6SIsT51456fL3bgck9bBmcj5zWc7zS2km65Xg3B9S8
         74O5MWC+ezLfvbnEVnbEGdhVToCt0lM2aX/HTJS7bqPLgiUtL49E0sLSE2EkCYWQyfld
         SDsQ==
X-Forwarded-Encrypted: i=1; AL+hErEG1M2wMZoJ+aLWO5ExKz1FkPD0vtcfu/cK6PACBsdDpE0BF0zaxs6JhVIg0kw1eoSbqy3+nOQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9hioq5JGzAedmrZ/zTXwlIHBf/QdU/+lOwjLgO2vEYmBa44vh6
	f6J6NNUIMdX6yvwZVwGC2Q4rSMlDIdoDcL8z8rWoQeZMcHEGxR5kLPiz
X-Gm-Gg: AZFdTZepE0isPG/JqT/ZdmB24tOEBSX6fq4fNxgoD0m/rneuSt65E5adYnr+GzE5OWY
	hCEaKLwlEahiS4++0CgOX2vEhPf+E9S8d1Xd4f0CemkJgbT3OciX8iIMIeMYhbC8TK/pY5wBpJq
	qgSBBXdkXSREmlb1VQc+E7c9idxi6Rq8zAL+UxwgMwY+XcclFFqM/uPoB9CKSYQDlDiexMtYQVW
	iS9Jn64/FrqB/2ObF8q3lYPzW+kMAtQ008ruiTQWBAqLid8yXxK7GgOW499xJezyYJKXeoSwoL6
	zLnvBZnR6kL0eqYDY4I8xb4bq2porFt4wE9Fk6X50WM3tSgMWizIbFRvJf+SD6o/0WysSg2MZiA
	4eQqivSYNLeo9W8dOGbr9AmlkGVB8LI2lUyn9Mv6zHtfZqHQgllLkTWJvYC5VKkX7hRZ5bIAvKd
	2T9l+oqZOG/gHaCN5DADJsvVhEJHBXvsjQbsIjhu067EjNawZsfGitmrjPWM6D919JCOj6xc0YW
	mKa5l4VeBcU190qql69OhQTPuP4Ju8H4BXdEn/g+10oxviTZpPfhQAWd97gajalGT61nqLPwZ+y
	B9JtmsNMst6J2tMyEb5MI51rF/qHaH8vfM1+Tau1OU9E4sEOAMuDTgjzy2bj0Uxtp5C5/krKIWn
	kH4Aou/HMcR6EISb55qE=
X-Received: by 2002:a05:7300:c00e:20b0:35e:d21c:f33e with SMTP id 5a478bee46e88-379651ecb3emr20450412eec.1.1794880483783;
        Mon, 16 Nov 2026 17:54:43 -0800 (PST)
Received: from localhost.localdomain ([188.253.120.78])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955332a77sm34139971eec.4.2026.11.16.17.54.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 17:54:43 -0800 (PST)
From: Qihang <q.h.hack.winter@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Qihang <q.h.hack.winter@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] iommu/io-pgfault: reject partial faults after the device is removed
Date: Tue, 17 Nov 2026 09:54:09 +0800
Message-ID: <20261117015409.25492-3-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261117015409.25492-1-q.h.hack.winter@gmail.com>
References: <20261117015409.25492-1-q.h.hack.winter@gmail.com>
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

A report that already holds a reference to the fault_param can still
reach report_partial_fault() after iopf_queue_remove_device() drained
the partial list.  The node it queues there leaks: the parameter is no
longer on queue->devices and its final put does not free partial
faults.

Reject late partial insertions under fault_param->lock: add
fault_param->removing, set it in iopf_queue_remove_device() before
the drain, and test it in report_partial_fault() under the same lock
that the insertion takes, so "check" and "link" cannot be separated.  A
partial is then either drained or rejected and freed by
report_partial_fault() itself, which returns -ENODEV; as for any
non-last request, no response is sent.  removing is never cleared,
since IOPF re-enable allocates a new fault_param.

This only protects partial-list admission; callers must still quiesce
reports for the remaining lifetimes.  It is not a general teardown
fix; the cover letter lists the paths it does not cover.

Fixes: a74c077b9021 ("iommu: Use refcount for fault data access")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
This applies on top of "iommu/io-pgfault: unlink partial faults before
freeing them".

 drivers/iommu/io-pgfault.c | 12 ++++++++++--
 include/linux/iommu.h      |  3 +++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index 55a3c29..51d0d1a 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -64,6 +64,7 @@ static int report_partial_fault(struct iommu_fault_param *fault_param,
 				struct iommu_fault *fault)
 {
 	struct iopf_fault *iopf;
+	int ret = 0;
 
 	iopf = kzalloc_obj(*iopf);
 	if (!iopf)
@@ -72,10 +73,16 @@ static int report_partial_fault(struct iommu_fault_param *fault_param,
 	iopf->fault = *fault;
 
 	mutex_lock(&fault_param->lock);
-	list_add(&iopf->list, &fault_param->partial);
+	if (fault_param->removing)
+		ret = -ENODEV;
+	else
+		list_add(&iopf->list, &fault_param->partial);
 	mutex_unlock(&fault_param->lock);
 
-	return 0;
+	if (ret)
+		kfree(iopf);
+
+	return ret;
 }
 
 static struct iopf_group *iopf_group_alloc(struct iommu_fault_param *iopf_param,
@@ -479,6 +486,7 @@ void iopf_queue_remove_device(struct iopf_queue *queue, struct device *dev)
 		goto unlock;
 
 	mutex_lock(&fault_param->lock);
+	fault_param->removing = true;
 	list_for_each_entry_safe(partial_iopf, next, &fault_param->partial, list) {
 		list_del(&partial_iopf->list);
 		kfree(partial_iopf);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index ef50437..5d56e66 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -846,6 +846,8 @@ struct iommu_device {
  * @partial: faults that are part of a Page Request Group for which the last
  *           request hasn't been submitted yet.
  * @faults: holds the pending faults which need response
+ * @removing: the device is being removed from the queue, no new partial
+ *            faults may be queued
  */
 struct iommu_fault_param {
 	struct mutex lock;
@@ -858,6 +860,7 @@ struct iommu_fault_param {
 
 	struct list_head partial;
 	struct list_head faults;
+	bool removing;
 };
 
 /**
