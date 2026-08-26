Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8024543846E
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 13:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787752497; cv=none; b=EsFcXzr7Q1HNR/5lRDCjh3VcbhulcpNo1CJeJpvI9aFURDEZaTu6LITNB22HAzlp1m45XjRudi4wfEtxehkAQSDZFNzVgKsTIZtEvloxyDGig6ixs5SYwUL/M9ZQLBvS4q1rUP17RHQJLuE+wjvL1jGYuYIS/c+DR09nvhtMMK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787752497; c=relaxed/simple;
	bh=KHfW4skYneuB7R8T7OJQcC5K2V6xhXLwCVM4bph5ulU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qPHi+cUGecm07lOr2Xrz0Xao+rXD+Ycp3M+Z7OBAR9RoNmEJus6jzC3Vwbe/pA1qywP/ZrAw7BzO7dNnRLwPKtnQPiUmKn0s7dWm1IYGE3/Irlq2SyOwOI69uL2Wi4NoYTd514+I/P0EJcWBIcTbSdCsyvoqIXhGTUyYgiiRShY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KBvC4CsN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=juO3kZB8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KBvC4CsN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="juO3kZB8"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QCUFx7948999
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 13:54:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=NVdl4MhXtb4
	OnEN33//nZ96kPgkyUxM2ldx28fo594M=; b=KBvC4CsNn8Mzjl/09HcUBJomHZ3
	BRovjXgJp7MgsSExeRNqSGvtg7Lw89mZbrQihz7FyhVtVKVWAKuGVSGWpOBSE7pn
	Y8fnLhLhuaG0omKeEBz3MLRN61vY18GzV2WNHBGzhXW7AoWGFhyDNNH0JSrpn9gD
	49KFsQpBxySlpoiFpTEbEFzAhq5d4+pP3B0XFhC+xRikBxJuFkGd7RbI0C46MYxu
	JC2ySnHr3MqIJbTU6hvtTMl1dAA0tM+/DgyDsqZo4i9rUmAIHgaV+LpLCeWmmu0K
	cBpycXOxAZEPDu5B1Drw6XL15I9j+wGsP8E+C9AcFMyGfiWEUehlxcRZ6qQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga0758ats-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 13:54:52 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-526da7e3c9dso9723171cf.1
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 06:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787752491; x=1788357291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NVdl4MhXtb4OnEN33//nZ96kPgkyUxM2ldx28fo594M=;
        b=juO3kZB8fVLyf/ZI6gE3qGLd7u41D5yNHon0c56oy8zlY0ZUrYw1kd69GcpqVphc3Z
         GD2H+DKP7srN4clK22q8mWoUpwvwaIywcDzAG+0TsdwvFMRdOnRrylNscwylg5bDrrLR
         ogNhB9PoMp2ANS2iBv6oQbE7252VxYFI/e0ZdGRvbijBVft7CDL3JX/kXZnnwM6pvLN7
         8jwQQKzDxJuZ7WPS3Ivk9L29LdrScZH6EgvYjFHRLEKHQZj6ABTjMvgMIpRNsTgRD9c5
         GTAN9s4vQYZaFQt+pKgeRo+M1BtWoj9KmKgis39C0cHnCImew6XflFDJKW6Sqc2I6YSg
         KFFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787752491; x=1788357291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NVdl4MhXtb4OnEN33//nZ96kPgkyUxM2ldx28fo594M=;
        b=FzXMsDoT+7r3xGG7ViwSFEAZlWXIAmljVeOgQsBAt3lp50ouvnrKZvjf2V2IAfKd4+
         TeHdiLh9DzSjrUsf/w044ID434mi8rLZPkueGnBDH+ur6BnqO16mP9/AlhQipZho6CIF
         nEfRgnSSaKin2zYvtAVzamliNQVuS9tEWM2JtMMWRjtHttBjWlBrqJf8NpAwXaZ6LKQj
         NWh6a3VYglAC4Vb5jHyZiGk3o7S5XgrcLGiV+j1KsRXD2fwQUhilMlPKpqjSdQyZ/QiL
         aDTgGnBAhbu5ObDZdCN9rztbT0mhnhr48IZYTFNTU6Ib77WSo3CcyOtVGuorBeMTrgMN
         m3XQ==
X-Gm-Message-State: AFuF++lwdFzXZ62W3qMogwSkiREYKGvvHcYOEc3nQry8o7AXvDxKhxuy
	dq01tzXGKAjK4/pj4tBiWMUqjkYN9o1zG4PIrKmdJn/dvg8HcbgDoqqwPn6je564YwVcBScRh5g
	dSVmKKIqfgSOYS+aEYk1OeTZuE0EJ+QT/LnW+oApwn8i4GN3E5J/ElEDJj40=
X-Gm-Gg: AR+sD105JJ+raDl0hI888uYWxcJCSeIlrx4+jYtIq3blg07yIFuZt00SMrI3kxeEAar
	4n7TG8ke2M/5fze+esQm40nJbqcRX3hjx0tz2WeZVBZp1MH2fktc6nw+MlBw/jMcPEGdnJ1tBsh
	DzNfjNrYVEjkazh48SHeD1V6BvC81HptQGf9cgQm0vargim9t+oyj/QsFBDGZHNpFx9FnZNRrMO
	sF2y09ZJlLbZcEJj780KBy8hplxktmTIDU0JxDHpN3G9KXYP6sMEhcN58p+XWJ006NAw/EOxOLe
	VmiFZEIw/06hUBJu0h37AkX1XCGFjeqorUL8VlDR80IrJWxC7VqEK5Plyb57l7TJiiMYApjhOwP
	kX28ywMWCWsebu4kD2I2Vw2y7dJYNWiE2534/Wl7l
X-Received: by 2002:a05:622a:550d:b0:52e:3cf7:2fa4 with SMTP id d75a77b69052e-52e423a723bmr73041801cf.29.1787752491411;
        Wed, 26 Aug 2026 06:54:51 -0700 (PDT)
X-Received: by 2002:a05:622a:550d:b0:52e:3cf7:2fa4 with SMTP id d75a77b69052e-52e423a723bmr73040741cf.29.1787752490708;
        Wed, 26 Aug 2026 06:54:50 -0700 (PDT)
Received: from hu-yabdulra-ams.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499dc96bff9sm27905055e9.5.2026.08.26.06.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 06:54:49 -0700 (PDT)
From: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
To: kernel-team@lists.ubuntu.com
Cc: stable@vger.kernel.org
Subject: [PATCH 1/1] net: qrtr: ns: Raise node count limit to 512
Date: Wed, 26 Aug 2026 15:54:47 +0200
Message-ID: <20260826135447.447480-2-youssef.abdulrahman@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826135447.447480-1-youssef.abdulrahman@oss.qualcomm.com>
References: <20260826135447.447480-1-youssef.abdulrahman@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: nlpnO360hnmqzeR7ZYPLeKxMEZOErZVY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDExNSBTYWx0ZWRfXwvn2sB80FpcU
 3JhECRlkjmmfTCSDD2hwEnCB/a1HOyvUxlITUnvsbaqmmKTsW9Thuiyk6pDtP/oABG3MTqRPX/w
 zt4cchJDIlMP4F32gZgpxp6Cepq66AFD76/8T18V2QquAknzBy7n3TUqh9uY4mxFVwXNwBEW8EO
 rdlUO3MOaVtQeVQrqSVGHKM+Xd/QEw0YQATsAlKLZFpRSfZ9LqHlY62c2KnxhLh7klrCsuGdYUK
 uh9Dvo6pISj/M6G63zsm2SlDHvxQIgT7o5QAlcPG72FgqcTA+RgoNRyMaDRC01MdgUuHTs03INy
 2gfT/P4EI3ta6tUfck7frpcVirQ6wstCKvisplekCyCGwHNh1BSPhmzBcU7u0Isd01SN7dLnNv7
 rQmC8V507JSvXBhhZFIUnpnGuG0l8OZwF4yj709GpRuLptYZ3QViGa6pre1kKDvbtIRSWWvRvBf
 rKih36P1WU9fYXmMUtw==
X-Proofpoint-GUID: nlpnO360hnmqzeR7ZYPLeKxMEZOErZVY
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDExNSBTYWx0ZWRfX8eva+B/ORl9a
 ahJXWF8mS/AVrlDb+BSPYKoYWhcVAqVM02kDohn0H4YfQVEWkXkWzN74iLpdnvyyt4WTcIldBQW
 tN72IN66PeH3H7S3rs+ojqfMY2Yh5dg=
X-Authority-Analysis: v=2.4 cv=RPiD2Yi+ c=1 sm=1 tr=0 ts=6a8ef02c cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=danhDmx_AAAA:8
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=4pVNa4VuK2S7h9LEhL4A:9
 a=a_PwQJl-kcHnX1M80qC6:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260115

BugLink: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2165140

The current node limit of 64 breaks the functionality for a number of AI200
deployments that have up to 384 nodes. Raise the limit to 512.

Fixes: 27d5e84e810b ("net: qrtr: ns: Limit the total number of nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
Link: https://patch.msgid.link/20260713145901.212396-1-youssef.abdulrahman@oss.qualcomm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/qrtr/ns.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index b3f9bbcf9ab9..e5b2adb161d9 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -76,11 +76,11 @@ struct qrtr_node {
  * requirements. If the requirement changes in the future, these values can be
  * increased.
  */
-#define QRTR_NS_MAX_NODES   64
+#define QRTR_NS_MAX_NODES   512
 #define QRTR_NS_MAX_SERVERS 256
 #define QRTR_NS_MAX_LOOKUPS 64
 
-static u8 node_count;
+static u16 node_count;
 
 static struct qrtr_node *node_get(unsigned int node_id)
 {
-- 
2.43.0

