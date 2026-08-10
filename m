Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0663B2FD4;
	Mon, 10 Aug 2026 09:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786355708; cv=none; b=jYJ9Wvkv3/T3rHCfeQOM0hMduYkfEJvE+n85qVO69O0ZhBkdfG+8yfV4rJWgM5H+JxnHAXJH1bCold70xkccJ24zrH4xUK44XntfiXkKFZnWN1C91jvo9v5PsCzMxnOlFPt7kcjHHcA2Js/wrzLGOnH636ad4aS6j6kTkSSBSRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786355708; c=relaxed/simple;
	bh=f3caQ2UCUMk5my+imjAfiCG6fjdRCHqq6UR3F8QpURc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OFr/IM2IoCarr04Tz/TCDY3XAiPYv+al2VMnWr9OhZTJE2Ekdx7W7hgT2xdIDRQ5XwWnMqJQCZCkgkqr2Xc3NY5jf9iiVF9zwczWn56DN7EhfXtlc6W61E58U5bFR7IRHUCOL2twGdwDnec82K9AMph1+iz64q+nGj5xTTh8o5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Fy31fysw; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Fy31fysw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1786355674;
	bh=6wE0xvjj3+AnsYJVrqK2gGz/Q4kGKjKA2hUYKFIzW4A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Fy31fyswBSCDNMrdFv3Vm1fJ3njgRqjOwE0wWRvHgUs+IXAI9t9ivMsUluzQCL30i
	 ry2lUO74OBQ9YWHdJKAobLZhQpaivKFQx78K/hwkDaQRXEhnEd7mgKfwJLhTjwxf0C
	 pGJKeaEZHYRd9dHxGsgqPjoWrU94D9NTwbVTL7rU=
X-QQ-mid: esmtpgz10t1786355656t7e9814bc
X-QQ-Originating-IP: tI+UWEGuDjn0Cnqyl9unKI9UELnJQoNCbetKoAfq3Ko=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 10 Aug 2026 17:54:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16993563754584466698
EX-QQ-RecipientCnt: 6
From: raoxu <raoxu@uniontech.com>
To: sakari.ailus@linux.intel.com
Cc: mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH] media: v4l2-async: avoid deleting unlinked ASC entry on link error
Date: Mon, 10 Aug 2026 17:50:12 +0800
Message-ID: <660DEFF8A732CF1A+20260810095012.2213444-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MhIE0ZejpDV/nb1PmXIzcBo5OHWRs3l8CsJgpAqdIgtN/drpoYz0b8I5
	36l3vGocQMhV19Wq9doOvjLs6uKhzw0txHzIOZYfQLiTulX2KMXaNU/i/xwWFjkoDgAsft/
	WrxN8iTnBy6QMnsVPPvP0zcDtjdBfGY0kCGslEpKJRWHuyBk8Yihcw29svn1fXKLPd/6Unk
	W0pSsRNriYDYmVkVRc5IxQ0z6X9QDV0dompFhrMRvr9+3FXCvqkC493S3KNLiVr913Oxjfq
	anvGIZ3BjqUp/6F2mKe/YVhY+FFu4Wmd9lahicbn3vuOrgZa6jCU2wg81s27CmObG24x+ch
	E74j8uimJ5ta9RMWxCyPM3f1majsTRwd71AqF6qBXuC2YPQTsOiWDxXBP4zgI9w49r7+6/F
	AVdojZM7BEJMNdG6Qw5HPEnu8fyEapBCKVopVNhQKMLhEK8hrT2vphVULdsidT7e/6SCSgT
	m3vHvpmmVRhx2M+zQXt4AQ/EfNJjZBpBSOBNY143EUI0Rv9gXxnH3YxYM/2QUpMvZldDUQK
	OwHqLnq2Cwo+twhcnQa+eCntabFu1GIixax9rQs+NnQUBUaukoPpMgPQAvmMbfd8VqhOee2
	svBCwLY4fmvwlJtOTp/4eRvdahEK9LPLjnMOFxyju6k+STjQMOM3VKwRSnjRFqwbMe7Um/L
	U99st+6toiZ3fRhirUP7Hdi+bffFSnBlqAfQ0eYE+Vhfhb9tIH/mpFll4IBE5pJ7OId/N+v
	3hqRBAj8u+wyMvGNBfvtkm4KjTj0xI7eR0onN/eppQqpdQW3y8miB32C+w8y8o+gM7TvhNc
	pKTU3fU+wa9HByP54mOmeWc0jKv2aUzKxFb9k9EtLmdly8y6bBXcE7/3pcVQ33ItsO03Q2h
	HxObmmvl1oqyE8jtSqU6KdcDwVYIqTgkkjGkBNtW/sbCpN3hbqX6I9Na01y9ithNTJi74VN
	9Q7NzW15MGKgturQkcFIdMGgLExVAYEYT+k4oiybAZJDSl6wf05axAgpIua1c9Jjh5yv+fh
	Bv1a9i5WtT6ngw8dib7CFwQHKpRQ6yBw8dF/Z01cyQkfcINN1BIkQf9wtAtJnYYB9PMgBFM
	wU+Plnn4Yzj
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

v4l2_async_match_notify() creates ancillary media links before adding
asc->asc_subdev_entry to sd->asc_list.

If ancillary link creation fails, the function jumps to
err_call_unbind while asc_subdev_entry has not been linked yet. Async
connections are zero-allocated, so the list entry still has NULL next
and prev pointers on this path. Calling list_del() on it can therefore
dereference NULL instead of returning the original link creation error.

Do not delete asc_subdev_entry from err_call_unbind. There is no list
insertion to undo on this path; the bound callback and sub-device
registration are the operations that need to be rolled back.

Fixes: 28a1295795d8 ("media: v4l: async: Allow multiple connections between entities")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/media/v4l2-core/v4l2-async.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index 888a2e213b08..0aa4265a6782 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -392,7 +392,6 @@ static int v4l2_async_match_notify(struct v4l2_async_notifier *notifier,

 err_call_unbind:
 	v4l2_async_nf_call_unbind(notifier, sd, asc);
-	list_del(&asc->asc_subdev_entry);

 err_unregister_subdev:
 	if (registered)
--
2.50.1

