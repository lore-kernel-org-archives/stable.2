Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793963618;
	b=T539o9K7bes5esNzy4LkbkmdzZ7ZHr3/FKbsKJcndwUEYrT6ECVVEYMRAzzLRPKfnf8+
	 TMwrJoth/sGW3mTObaozaVUjNBm11WBf2VlTqNC8Y4nKCPnvElYzj17LWyh8hKWVrY/tM
	 1UGUPwRjn/jjIB8cgLA2fH++EJvv1offtDF+ZTBjTebSw08/MezG9mWz5wz5z5VRoOj9D
	 nHejTzOG75Uzg2gI9aV6BN3Gjb2ExMdbAi3EuhI2h1JTQFXFxpLMD1IY70xz+vCKW2v5F
	 ociMR6Ygnone/PqvXT9A4bzz9UtatfhBGBEfmPlQqnSAt/gZ1shd0++QSYBQX4uF2+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793963618;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=XW52UdCrmkSU2CFHGJcm0I6RcRFb9njYbyKT3jvjP+k=;
	b=mKhkdE62fM7+4q8GjNgyC8I8jDQhnndLx1LDwG9ecl/mID/WZCbNSDjqGFqW00gSwOps
	 UGFD10l2Yzx8L5b4xBeklN3m5GTCc9PppL4QLcCJX5LAc5M7mPJVHwgxP9Su89RzoMMJu
	 MIVaAh4a6JKssrvl7CN3YnQkIXy/cM9p2+HOdOAh7virqeDfOUFN+goUnfKF+E68CMoht
	 mntKL8RMNB01n+bY5PrQMurldWScfLH5WSNUMvVk4BVH9ngCVNLjXuv9bYkUzO1nVi171
	 ZaFjMY68Z+T1w1+5FpxutXrok/B7u+Cz/uRqUOPnp7KygpIbi1IpdDDApe7OhmlB8qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jPeFjlND;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FUTDjyft;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D23606A32E
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 11:13:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4D23606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jPeFjlND;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FUTDjyft
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6APLHR114725
	for <stable@vger.kernel.org>; Fri, 6 Nov 2026 11:13:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=XW52UdCrmkSU2CFHGJcm0I
	6RcRFb9njYbyKT3jvjP+k=; b=jPeFjlNDRAk41JmbgZciWPHgR3+DwR8XKFx/kt
	NHUj7NwJ6Q3h87H1/Yf8Q0W5YuO0rBlD57t6SjlBydmh17WkCVg6o+h+4XBJ5ozt
	ye4fcl8OEO/kg2GaQvTOjkwVGRfyeJufoljilK7bJDNUrXKirmrA+QfAEu7OfpyB
	3Hn2DwpE0DF66iDHgKc4t/N2FupwYNJnxMkdT8ZErhYXT+hzG900ALKieHW2UbTe
	iOAxWp2cEjQTLiffgeJoWQevf77WgJoAurK8H5f9bMy/RHySNybuP1GxOLIqxi/a
	RsU64j9YdzXqNvpo4O8wRUAE4hwntSiHCywNylgin0gUTDAg==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3patgex-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 06 Nov 2026 11:13:36 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-999e001953bso329649241.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 03:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793963616; x=1794568416; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XW52UdCrmkSU2CFHGJcm0I6RcRFb9njYbyKT3jvjP+k=;
        b=FUTDjyft0iLd4uwL2P5wvXBbUSnZttUA+bPvryV6OcPlfR/igitrZVyOPWKZ7iKFIu
         DddNP38qDzbdCwSQJoPc0pa3UiJ0SzfU4cUTFddzXJ0z9KC6P9NMe9mXpradApdT/RXF
         uRop1mTXysySszHJ4sbT+z0ooLc4pupQDpVURzlS0ccCkYEWQnMtVsGDi6xBZ/mf2epI
         h5TFMpjgCgjxyEn5RkWtSv/Aw9ZhBh8NEFhqyjJREAZDRckzraum/vG6drD3j+poPzFm
         vXdW6sLqgCQTAJLpvBpE12PaOj63CFC7/dBgKkQlZs0/ga2q5uUZ1VZ7RXws0gxLDeZT
         Yg3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793963616; x=1794568416;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XW52UdCrmkSU2CFHGJcm0I6RcRFb9njYbyKT3jvjP+k=;
        b=l3zgBji8uTR6KBHq4Lg0c86vfLeXasglB2OVEgH+IXm+h/R6yPb5Z0hGXhiRF6JWOp
         gPRw2QKiLH7z9WXZ6P/eyllGbKG+yMV/umWSH1R/pXS9pwgpiFQMpgiukORtHKFB1V2w
         I5sWChmeh10kImu/T8n0sMavP9BWhuUHEQJTw0Nr1A8+WBzPWxPIBzynsISUBQa0o/WA
         UqVtaTsfLR8Z6Gx1mEdIhq1A5c8DuyqBgghdJ+EltamR5SkNi3kU1dl4jZEhLT5BrlTf
         z5WiwCiudCr7R3hxmyJBoUthbfLd/MxyOFAs5MDmS82aA+6cVbWZeGZv+V8upf1nz1Lv
         J4nA==
X-Forwarded-Encrypted: i=1; AKwUvBwxdrqp3iIfwmXAeo6v5whKq+LYTm5GuHQJmYn3VfML2wsyo4oHFnkiQmR5NRhb7JDdjIF2p6k=@vger.kernel.org
X-Gm-Message-State: APuU4Z9E5cRrVb9VirLsmtT1RRyjF50G6I+8QMb4T8rCKrPwyPn5CBKr
	c5ZxVQZOJKPcM16ndPds36mxhohgHW8/p2bil4ZhHpCDbtwVolyciXKslOEcpp4KUqS792ZBv3t
	Jy+/IH4pHdVY9suMdbi2p10d9R+qDisuENrGICJi7hGF8qg5VxRMKwmCrTeg=
X-Gm-Gg: AYBFou1A1fWNrT8zu3YSAlMdyMBo9KR6+PjmRRwLp+NeCBsrLY+xaXDVyo8iVhqkuh8
	WhkejDpnG3LPNesayIZxIqIO2vrOzsMcROYMrIOOGDUgpnPMJHILCaUVVXojX2Bk0mvU3RYAI9b
	7sy3Guk/PmyH57j2Xnab48vZIWzMWmbpOteRHzUYu3+b3v6u4Adc1VUf7CEmOGTKLJkZC/aHKpM
	t6yEkOjpHFs4k8WbCREuSiwPjbz2Yq4IzRo46NwaxARFwP7sjGk901S0rAKGtMDXG2bKjT5FeW5
	KGswKyNfdtd9FU5P41Th6wffnfJdNMIdOs8F+BR6kPuXCyDMteCIyGv0nqXyuFgdGkdVm7whYwN
	zyYj7mFJyfCYVIHVTeZXpRbGSV+FbWEvt8y8sN/Qu1C7UHch/3pMMFkEEjjLHB/6HQ72DrbEOaK
	la4g==
X-Received: by 2002:a05:6102:4485:b0:7cc:16e2:c1a8 with SMTP id ada2fe7eead31-7d2a15427d5mr1236235137.8.1793963615605;
        Fri, 06 Nov 2026 03:13:35 -0800 (PST)
X-Received: by 2002:a05:6102:4485:b0:7cc:16e2:c1a8 with SMTP id ada2fe7eead31-7d2a15427d5mr1236227137.8.1793963615130;
        Fri, 06 Nov 2026 03:13:35 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d6d63b79sm3183154f8f.20.2026.11.06.03.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 03:13:34 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 12:13:28 +0100
Subject: [PATCH] software node: make swnodes hold their own references on
 parents
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-swnode-kobject-parent-ref-v1-1-77dbd7213dd0@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFe27WoC/x2MwQqDMBAFf0X27IJRatFfEQ9Z89puC4kkQQXx3
 w09zsDMSQlRkWisTorYNGnwBUxd0fKx/g1WV5japu2NaXpOuw8O/AvyxZJ5tRE+c8SLO3GDDPJ
 8WAiVfi1Sj/97mq/rBnbpwBhrAAAA
X-Change-ID: 20261106-swnode-kobject-parent-ref-3bd9b9b75aeb
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
        Linus Walleij <linusw@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2682;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=DgGmt26jdiGxwAImE7adK1jqciOsosJz/aF/TrpLB/M=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq7bZddfcbboI5xx8Dq0fYn9wm1w6F0bhJ4f2/m
 JrO6JnrpDiJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCau22XQAKCRAFnS7L/zaE
 w7ExD/450rySapmcw3fHkBw0K+oJ+u4K6ueGWCBEvXXacPV8DfV/CRsPh0/Pa2+h0EOzqj24Yst
 gohwb1WCCO8jICdehQPDrWPFTAoQvjHLiJSHucLL0+uBv11+LJWrsYETVaWSubOFB3IdVvvjibo
 gHPuIB4NcBhFvNVNjzMa1XsOHGkRc7+KGnaBaAYEupV5xkxwQzfHnTjMdCwRgkmNb5X70SNRHCe
 Mpgq4vZHcGWy7BgTySRfnzCxhQ5HON1EKvdt29CIFaL11Epn3p2TjRyOxn2+mfdJCFftOudH4gq
 8fZ9Ig7/MTfqsoHjgnhAvigafOahtC2ifpEEp1wqU4xrAIO0JN5jTsSlm9cFHJzNL35kp2tc9Gi
 zCc8USU/ClhIKjScsBGqNBEqicEsME3M11o9si9EkpV/vk8VQL6Hjt34kwzgewZhipMkXPAe/bu
 Kgw1D7/ZttH9u7pGaX9E4lxmaymhCX8SkRCtGU2cGZzwTXLlAe1qBGhnXMstDMBaexDQ8489cvJ
 8dJ+3IimaWBLGSAuU21qgeW1CcL+H//JJlWfz+YC0dzgoKrKv8PT0iKmLiEeceBKpE6Od2+dwJX
 NbmzFRLozA1pWS7z2m4svnafXoGFF3KZSc/s7SRgxp7eWDf79DVfF1ywckfILDVzpiIgMCjMB3Z
 vo2GWcI/DKTHegA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA0NCBTYWx0ZWRfX5G/7lTn/xx35
 ZG2T2K+d/bteO1ng+18BLNaUWrTkJuj0Ox/Kf/0yhd1zfgnpjfZZSVouUuzHBlRwloEIh87XJXH
 pOcbdLyTqLdEzBH5Qzf4UZ3RAQ99OlO4m6clYf1Y0vuVsGBH8+Lzc0WCJvXv6JiaRs5gwsurN5y
 +abYbE4J5lRU7VdVeq7+c7XG7sz4+JROmdODh9Fhbhp4ZyGQaOjdAAlIxO5e400KJSIxUcXPWMI
 mQ7/mLQSOndP/PX8g3mESmDkEhcsV/gBuopbWktHEg+yuZKVmyRshQ74MREOnTC28KlkuXdBLeW
 uYl7G90PQwrK7ALHPgyvXPJQ2i49ZG8zkkqQjPUHuT4YkIdAw8h13wtR/seT27LZ9tB6oR893iM
 gNVBHK+rozJDswLzvT/jRsGVLljFxHx7wcpDMA1sEEnudlxtDWBuTo4PtNF7+C3tcrMHqonSLpl
 uiYxtpWAfvLrLF7elbA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA0NCBTYWx0ZWRfX1VHtTNWicbn4
 KepWiW3KDHIz41hUvVkXJSPHvmnsmcUnAG/+QMkLwD2dbPpjAc/F3d/32Fngmxg0ZCcQ4hZjBjX
 KQyHAMzKB1BXcbgT+MnqZdxdFCBU63I=
X-Proofpoint-GUID: JedDfLcyOFmKLWJ2T3ki_aZHLPP1zGNo
X-Authority-Analysis: v=2.4 cv=P4ivFSAu c=1 sm=1 tr=0 ts=6aedb660 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=gm3xcvSgROcOYQEXUbwA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: JedDfLcyOFmKLWJ2T3ki_aZHLPP1zGNo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060044

In swnode_register(), swnode->parent is assigned before calling
kobject_init_and_add(), which normally acquires a reference on
parent->kobj via kobject_add_internal() that is held until after
software_node_release() completes. However, if kobject_init_and_add()
fails before acquiring the parent reference or drops it on error in
kobject_add_internal(), swnode->kobj holds no reference on parent->kobj
while swnode->parent remains set.

With CONFIG_DEBUG_KOBJECT_RELEASE enabled, the random delay in
kobject_delayed_cleanup() may create a situation where - when
unregistering the child node and then the parent - the parent object
gets released before the child who's left with a dangling pointer.

Acquire a refernce to the parent swnode when registering the child and
drop it on child's release.

Cc: stable@vger.kernel.org
Fixes: 59abd83672f7 ("drivers: base: Introducing software nodes to the firmware node framework")
Closes: https://sashiko.dev/#/bug/linux-82933c14-d212-49f1-bd2f-d4ab1e16fed7
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/base/swnode.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 84a77ffa3dc4bbcca62bbe67c3390693500b01ea..986dcb933d2c9274e9000968f115d7fccc2d103f 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -843,11 +843,12 @@ static void software_node_free(const struct software_node *node)
 static void software_node_release(struct kobject *kobj)
 {
 	struct swnode *swnode = kobj_to_swnode(kobj);
+	struct swnode *parent = swnode->parent;
 
 	fwnode_links_purge(&swnode->fwnode);
 
-	if (swnode->parent) {
-		ida_free(&swnode->parent->child_ids, swnode->id);
+	if (parent) {
+		ida_free(&parent->child_ids, swnode->id);
 		list_del(&swnode->entry);
 	} else {
 		ida_free(&swnode_root_ids, swnode->id);
@@ -858,6 +859,9 @@ static void software_node_release(struct kobject *kobj)
 
 	ida_destroy(&swnode->child_ids);
 	kfree(swnode);
+
+	if (parent)
+		swnode_put(parent);
 }
 
 static const struct kobj_type software_node_type = {
@@ -885,7 +889,7 @@ swnode_register(const struct software_node *node, struct swnode *parent,
 
 	swnode->id = ret;
 	swnode->node = node;
-	swnode->parent = parent;
+	swnode->parent = parent ? swnode_get(parent) : NULL;
 	swnode->kobj.kset = swnode_kset;
 	fwnode_init(&swnode->fwnode, &software_node_ops);
 

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
change-id: 20261106-swnode-kobject-parent-ref-3bd9b9b75aeb

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

