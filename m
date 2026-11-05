Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793885473;
	b=G+teTZZ4SZXL8Ng0grS5VOWo9DICbQDv8AwCnazV4Bq++hRIKjqeUOks59GI3Ht7ixr/
	 nZKxp1U8kMhg/kcONd3n/MH6isEPfGT7zwa6pgmU4/mscOjH0UGd3vrrKMT3Y+28o04JV
	 ibZp8DPHSFNHvGxqwiR56x18wNhgXJuz+kfQeLxmqii4RpOWa+IEpLrFeLBnOVwIrkr2X
	 9fCETPuIXOUaXo6Vsy2js2ElZqOvfdJ5NJRXUwTwFJrHf1RtKS73rVDGRXlX3rTCxSAPQ
	 Gq7Gum9wr2jXp0xoYhvJEe/dPtP/gVqLJpPn9kEj6t7WnYJyqUu+CKQfSWeNMFbmLiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793885473;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=QvBNxBniZKlP5d2kcfp20RqdHGp6PKnHt5QodKeOHlk=;
	b=OPUhI668IrRYPEIPZdkTMNuuwr8dAC4y+mpDhNlThp2TkOPMMke/e4rNObqL8TaCRgnm
	 /lpt0nYfy7wz5+z0TtZxhycyW559I0USTLdMWGSOU60N/TbnzM5TQrJAEF/IC0Yqt0xnq
	 oy8ev7BoVhq2res8UI3EOu8qg2IzyHQDO/dZo5o67QwwkAfbaWhgd0rFuDmdvWZdKbJK0
	 Te1psqWxOv1yHquX5m0XwGoIj9PFkfqtjhFDWsWj0gGrynMgU1IdrbIzWSr8urJeSKaHL
	 Vm7iMIOoKKqGq6xMJtRXaFQmtlKBlELcFzCJGYag+tSdRUxXzI0oG90o0wIFNOiC95Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=F3zlkwE8;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T3kGP1JQ;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E4C606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 13:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1E4C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=F3zlkwE8;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T3kGP1JQ
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59tNge083124
	for <stable@vger.kernel.org>; Thu, 5 Nov 2026 13:31:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=QvBNxBniZKlP5d2kcfp20R
	qdHGp6PKnHt5QodKeOHlk=; b=F3zlkwE8Pd2JS4uqxhQdOTYdHPLMVL/TwG4YIe
	M1II3yxwuDBOay9mC3/SIND9L79nn0fO5b1oeO6VZLM2SNQwiVybSRmHLfcndmCD
	qsqZ1+C6kBEc9UXBrm0IkXkR5zfgnJZaMh3D7Ol2S0spayrUy5Akz4ek9vphwmaR
	OaakvvjZlQqQCINImxB8wRDZCISU2KiGB5JnHufo+IFaWGEQq8huNH0+a2rdiut5
	6xRXn2BKa3BFkZhMeBF9mhXk4VhSL4zqxv41Hr1IkhWQYznNvFNAAbTTNylAURQz
	Z168LQvo5ZFHFqdigDnNVUDBnirGhvl7SAoRR9D8pIM3eGjA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrq1p11m4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 05 Nov 2026 13:31:11 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-945b0154705so301368685a.3
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 05:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793885471; x=1794490271; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QvBNxBniZKlP5d2kcfp20RqdHGp6PKnHt5QodKeOHlk=;
        b=T3kGP1JQnJ6poqn+uHrhvER9Uztd+EhZ861VDI8tZLcsklh9EqvmFkvd0EH2cCylQp
         7O1RJZ+FxTXexwndgIs6rFeBGBwqEDq+CApE5JEyFSwM35CJYPOS731nJ6uJKB2uyswN
         t7zZU7J8ucs9afGV72wLm8uIF9850BbbD8JR+HRTesyHpMJ7XnGKWMJHOPVd+MM1+cMH
         /HEWLOeCH/g5n+nncCOHfTv5Y2GzwHLytBKO8PfgYB0kNGJAnpbbWwKlx9pIbAl0n6KE
         E0CuItK7cpJaW8LefdSF7W4zD+fpmlLC8DbGNN+Jp0SXDi4Q5lIXRblSw7X6Eo6NhGYh
         AuSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793885471; x=1794490271;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QvBNxBniZKlP5d2kcfp20RqdHGp6PKnHt5QodKeOHlk=;
        b=i6O6u/g0qjri/9gpub6zzu6BW2eINxUl4/pf7RLZy8/3QMlDI+AMn67yP424ikKp/b
         RV8XgC2//ShOcPljFb+yc06y8ENjGPU3gilUoSXCe2Za33piZ1S1VdUWu5999n3v/4r7
         jU27LRRtufvHrOP0J4BpWEiG6wPTosgj+/Fzf8tOVzUo5dbs1ACau35UovRr2CrlUI0Q
         IjF1whG720yXgnENRP9MUB4KMjsTKKIpYkYkaqcYYCXUgimY1XRv+wMziWqlUhV0t01K
         7BilPOGDHWVTL3g2VLNIBRkMa6/T0rSZ7ICGvhMMkK/3y7rcRHE6pXDrUhHiRTCEA9WU
         APbw==
X-Forwarded-Encrypted: i=1; AKwUvBw47y5R69Q5Tb8PLm97zBUM6QXovwU/CnpZCvKH+XEFA0CqdHHegO4GB0nrL6aWLUC2YjCN1g8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/8hpBA9wby+xJX+dzrCY4gECcjAlr7YcZKPRJXKAWxgBNAdSFK
	7UF8WJP0OKlWMzXb9P6lPgAOE4eEhgV83QGAXPLfTXsLeR0iLrCY5w4RVZJ4HQevOE4CztjUMDm
	o4V1J19G2gzXDYMUN/9nDea/+Gina5ri2MQrVYO9YsfmMTmZwhGrNwMyQwEE=
X-Gm-Gg: AYBFou1/vaXXdjmGQ7YzFw1XPfRoKRK9yU2lbQVl0bWaR19QtTv891XhXYLZEVMqXmB
	N1gxbxqXBI22kzgbbMLo6EogUG7YOdn3+zwdW40P9dEgx7u3TwB0hpZBPDh783OMCrArf6Cya0f
	GsnlVthxQHnEoO9WADsXdqZ0LTQ03RHJhk7LkjHR1/7CnSkn8PiouTTK7cs8yM3AedgzeGUUC1g
	5PpfuZoC0ORIbZBnKeJkzgTlqEb/qU6biv2QddnXQRWbhXyeGTJRt6+L21jAnZpoHSjY2rEybSk
	WUlZiEtcdZ7sazS9wdwAnRwj0U5fXc82DV5N+tLf2zvgO3BDLkzK2Wnkxd0nALxteTG3AR7uRkv
	kVel3FBiB+OMsFxutdWWJRO0Z4OCUeJEvNCX/UOTSv1jGPcu5HbtivYbVumOLYn3QfqW6U32nj4
	95yw==
X-Received: by 2002:a05:620a:45a2:b0:93e:c12c:f131 with SMTP id af79cd13be357-9442180665bmr3079126585a.76.1793885470945;
        Thu, 05 Nov 2026 05:31:10 -0800 (PST)
X-Received: by 2002:a05:620a:45a2:b0:93e:c12c:f131 with SMTP id af79cd13be357-9442180665bmr3079121085a.76.1793885470323;
        Thu, 05 Nov 2026 05:31:10 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b572505e84sm63292005e9.6.2026.11.05.05.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 05:31:09 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 05 Nov 2026 14:31:06 +0100
Subject: [PATCH] gpiolib: fix stack out-of-bounds write in
 gpiochip_add_hog()
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
Message-Id: <20261105-gpiolib-hog-stack-corruption-v1-1-a47af9c51965@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIABmF7GoC/x3MQQqDMBBA0avIrB1IrIngVcRFTKfJUDFhoiKId
 2/o8i3+v6GQMBUYmxuETi6ctgrdNuCj2wIhv6uhU53VWhkMmdPKC8YUsOzOf9EnkSPvNcT+pRf
 bD+SMsVAXWejD138/zc/zA2ZN+rNuAAAA
X-Change-ID: 20261105-gpiolib-hog-stack-corruption-431b647ea556
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1561;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=VaSatjKhIucK/x0c2+EFH0QePD6fzX9GOqoaXfy2lXk=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq7IUcYHJH1NTLw9y+HpKyiKHCCa9HhnnUrok9C
 T1ttopHudqJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCauyFHAAKCRAFnS7L/zaE
 w2dJD/wMYP+cetabcmRqmrV1q++gULqSzp7XbH6neqE71XRuDIm0RALCLnjzcABPm3QNmDUJGP+
 wtQ+Ixfr2YRh72IdfDEJ8n4JehLopV208L7cvcD18PYy/oyw89r+W2yzompQ/wp5epxYAyYN7bm
 VbHG2zEM8BVIcudwP0NEnuCE+8YdRoAm+EDs7EpbfQZH+dwCkdKanvTCacff/80yeG/OT1lJfE+
 fLxRGHV4Ko3u5ISzcNBpJbNm0TgR95q5lwrq4RoRzOFDcfd1AC2o5oMKDQtG+lEx93DNRmI5SUy
 wd3DAZ6vQ9zYIlR5pXryfwT0VlH1X2t0uW04jdvwmShAhls1mxOPx0QJ8qOvQu/ZyRYoMHXQbMc
 8ZmCzBqyNm7pW7Aantl4cQeWMyazM1L6YIVVohs9muedW7mDGlRWKSzi7h3xMhncyA2GVKD2OIz
 dXGquSRhEQUxCTPioUQaFtHwCx5YlY1Qi2iN8mwQtJDPdHzyi7nppYIb+liFbK6cMdjLnrgLm0U
 pkSBNgG8Gzcdcj4YgEZKQwpxaUCDdNaMTTbdY1gobD1zh/fyQdIcoJ2KQdoR3GNewmcadOcyKuU
 kYTYYW/xp9ubwUJs7cMRmGHAiMu4fD8XNh3fZ3rPsbYcXEKu0ypD5nSIrSXTNGGq84MQEh8VLgu
 j7Ef7iwfrriVlZA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=AaYkjHXG c=1 sm=1 tr=0 ts=6aec851f cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=it0pbt-dyIlpk3O7H5UA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1MyBTYWx0ZWRfX7BlJ5jcZmXbs
 dozE7TAVyR10cSi4/N2MA27LipaSrG9VTje1HRHFhEUqQvjfgCKi2i7vn/84GTbHOv42+x5LNYp
 6AVvnGu/EoToJVUnYaKv/GjDh7EjRF2YUxeMTJAR/5hHKtbWS1ik16P4HSaLrnW+D9j1JSdpPBY
 JwOF/vG7FwV/uErAD4IkLGbd18nMfZoZKKb4q/6K5nfaWM54IuHacZIWjY1CqjUz+Ee7nO85axF
 Dn9gNsHlHWbOb3CoY0HYxY2uIKjO9C/xsitHnig45H3GxIQZpCfAOfARt/07LJWJIwO9K1zQCx4
 XsEklS9GJo351wwVZ1/lz0RbeOCmyiZhXhEpq845fkrxM5SWZC/W786FDSVfNBvTYjIfbiCY9bl
 qj0J3OkZDPAL/cat9QRrjebjNGQxvLpRXJfuDMCuDi1XQiVhADAmXbsvBN4SdYDoG8sVC+G+M9x
 P4eVwJAMhPpMgO3gOQA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1MyBTYWx0ZWRfX12hOZkH8zdUy
 9W+kilYmVW9zJzWTOoUEt34a+ieYDoyROT+8iY6HsCVYG8aeDflBkcvUyrblvt2XtBclU4uf2IZ
 MNQo2VH4UQFDoJ6gJLRw2FmrVFuAMs0=
X-Proofpoint-ORIG-GUID: Y1IZUmWV37hWmcpPf1JMWfEB6rz7PGON
X-Proofpoint-GUID: Y1IZUmWV37hWmcpPf1JMWfEB6rz7PGON
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050053

In gpiochip_add_hog(), parsing a device tree with an excessively large
"#gpio-cells" property causes a stack out-of-bounds write when populating
the GPIO specification.

The value read from #gpio-cells is used to copy the values into right
places in struct fwnode_reference_args but that struct's args field is
an array of size NR_FWNODE_REFERENCE_ARGS so a value larger than it will
make the loop write past the end of that array.

Reject #gpio-cells larger than NR_FWNODE_REFERENCE_ARGS.

Cc: stable@vger.kernel.org
Fixes: 802c51a83e9a ("gpiolib: fix hogs with multiple lines")
Closes: https://sashiko.dev/#/bug/linux-fdec1c0e-c6e3-4eb6-8746-d68a3f951374
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpio/gpiolib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index fbdeda2f278713a47c2e3d2a6640f387f6d92227..698f86fa14591be484f36999e9b578cb4946917e 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -986,6 +986,8 @@ int gpiochip_add_hog(struct gpio_chip *gc, struct fwnode_handle *fwnode)
 	ret = fwnode_property_read_u32(gc_node, "#gpio-cells", &cells);
 	if (ret && is_of_node(fwnode))
 		return ret;
+	if (cells > NR_FWNODE_REFERENCE_ARGS)
+		return -EINVAL;
 	if (argc % cells)
 		return -EINVAL;
 

---
base-commit: 8b7179210b22f8e48a82c5ceacb9d56a9c4cfec4
change-id: 20261105-gpiolib-hog-stack-corruption-431b647ea556

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

