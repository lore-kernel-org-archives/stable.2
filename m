Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792750456;
	b=TzgabgW0kiOVNk17VSA1Mo2s7OR+liOz1hgCZY6TxJtICLDcTD0Z5ESWTpVZ+GEtZESh
	 SX69PzqCm1ONFFkq+iSE9ngrEObtu2qa9VPV96uzdv9cdiQ9jMFV7JpM1R+UtzEZ9ZLHN
	 YruKBa9iZd0MD7Lp4YAM+Cwt1a5KGfuMTaqoCg8FBl8eY87k1qPUU9Rv4DkSAQSG8gWGh
	 xyZdoxPtzX59tCGhTPPlFxzCJ3nViGHyjlCcWov4/27TTMY1km/epthcIfgi5Hcl91fMO
	 u7XqlyR51QuHWhaZTIYjTNn5ytY3gqfIJXY6UA5n4foZ1EtDLOJCebBEDkxY+5YJCeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792750456;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=HAeWxfZTcHlKlNt7pgixx+1a1cs5BFavajxZrxnqPSU=;
	b=EMZdZhEclxqg2+QNH+fDfOa5rbO7VNkPfYJEwetGXAWaUqIK45DeuMr+5V2uw1swAzCF
	 WiBqc+2Sbedz2qY9ecFvGhCuTZUa49Ox4hhmt1uboGMtZaNLL83DH2mX85FSLFYmADpyP
	 UpAcGB0hgkDCXc8neNc6y1EPbJZ/zVv/SIsOP1mytqvYY5o6Ci3NxuRUsFUSbcwdj0Nyh
	 7mWQVKD/IhR+wZEviHy1yF1y3r7alVyUGU8S3CTssJI5VSxhyHgG6nOhf3jQ9VpTjGgcL
	 eyZnKBCmdIeo2vW4KpRmOzFTmCKCB36eyaqccN+giH82bNc7nJ5y+wNjdLnpYtDI6SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CKWpjrfU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Nghnq4Ei;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D751606A31E
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 10:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D751606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CKWpjrfU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Nghnq4Ei
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NAAUq22164239
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 10:14:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=HAeWxfZTcHlKlNt7pgixx+
	1a1cs5BFavajxZrxnqPSU=; b=CKWpjrfU33uGEonVYMJy2m8zQoYRqjtB28+6Bj
	g+1KXTkF9M2PuBUL5aFsvI0pDLmtg3vgQU49/V8+QXimJjyn857YeRzv59i8pJkE
	mjJU7uWnhXy0YThoBbZqrpWZc/Ww/NZUnRnJphAhkNyYResyqVCitX9PxbYmJa9Y
	pZkky6Esoo/LHTUC3UMIEmuQdlsEXYMKuvrei9JVatBmC01d6YGINLv9TSwIEatZ
	p3O8hXl3dPE7OGeEhwDCjknZ4tBY7HPKO9zhwUH+i9rlBCMpdnp3/ntxD0rW7ZBu
	DmPGdqlUmVk8tADOMhNyYzRAeiTI4uWpSNP4KARUA3TlGPTQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfpahum0g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 10:14:13 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93909014c85so132413885a.0
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 03:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792750453; x=1793355253; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HAeWxfZTcHlKlNt7pgixx+1a1cs5BFavajxZrxnqPSU=;
        b=Nghnq4Eim8BXfzav67zzlUl1PlCoj6N/+OxEtEyTyhIJZHhpMZcpyKqbDanpltpuHT
         h0f1FNevNeGh5v1+mShP/ghsQy1Ckqj1vc23Q42EsOkVDs/6rMiD7hrvDKl2v3FcqEYf
         7MUDfjzIkJlg/DnFRa+1r8sPxjHRvk50wWFD1vxxov9S6LLwlAOChBRTxqIpMQxdOMT0
         /mzQGwgQOyakn5KmgIKm96XfAEEd1D3OFQ16Z2HCJHwUdNBKul2ss2BwwuGIWSgx7Xzf
         UO6kwh3SgMax2EHmhCh+aEP6Tga8K6XR1Zeygg4x8IB034DK3W+j58fQwJjSF145NGSm
         HP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792750453; x=1793355253;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HAeWxfZTcHlKlNt7pgixx+1a1cs5BFavajxZrxnqPSU=;
        b=RQy+O+/rp5XQ6wkJbOW+d2Qp0v608FSDdIs1pTOVnXycIWYWIMjIX7O/GuzGlAP1Fb
         YCazayj4D6o43hHrSGMsJECe9rOj7KfBVlprDH/DJT51DxPEJg2Ja8f/hks6lLFvhBIq
         EuFQqX2H5WZ/LnRddh3cwvQOhQQHazMCHKjAcLZrzv4ZoE1VFswuS2DjCuHoHTmxGZkF
         +6tovQp3/8dO4l13tUr1IbuJAdIVmHT8SA1Ly2B6abMFkrwYEs/pkpz8lk4FabXmA0ws
         dSbkelziYWpPq8JHZtm35ScHawIRS6CFOy04ilUpxzfPWS0upZOkxwBsUxsfye0K2bXy
         ierw==
X-Forwarded-Encrypted: i=1; AKwUvBwztSO9P2LCJIJqCe+YXI80aGJN6NPmcGr3h773EM596j9VdJwhgJyRTZINOl47dl1eH0t05sg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZdgw15LIwsgotOd61GdNZ0lIoLZ8C4Hgh+SP4jc/45jrH85HK
	OF0ml/HzoLy40oI8Uu9tH+m2gLgDDknF/N5k1SuVfZfjilMupTmIeK8R9OB8r7Y8d3WPsKUTTed
	zHGYUjvSWR2wt+VJN8NhlJ0dK48miBfihhHTBKhrEZagrqU4uzHCoQ/Khims=
X-Gm-Gg: AYBFou3eFjOBNlWUnhBBweKwpw1kXKiQga4HEj34xfsmnx6xzfDkBVL5qamqrjiKugR
	qkqm+nvN5X1teb0lsqF4e64aRNadINL5uPdk1drddaJfgC6adftetASUyS9mi/tmEosuwywm+i/
	X5pV0qrMftpyl3PFTmZerTu46l3jxcHhCS3DFTyYIpcfAbj2wwOHTmP7+tpUHQ70RBHSd01Eicj
	Gq+QjN0Q4RC9DKnOs4zR+NemDVvn8wb0xx4NmiYwepuAXUHjaixduEcoyAc59+fceO3x90oBdk7
	ob5JZSwXJ1Plk8AAbpT1soqmOIs/vuRkrjNZfnMxJFf+CDHLxqd+75uK/W67ZX/qh7DznKhAnR4
	w/iAlbmOh5v+rPrBWG92fO3kJlVI3
X-Received: by 2002:a05:620a:3184:b0:93e:c12c:f11e with SMTP id af79cd13be357-93f6f858af6mr297885285a.74.1792750453250;
        Fri, 23 Oct 2026 03:14:13 -0700 (PDT)
X-Received: by 2002:a05:620a:3184:b0:93e:c12c:f11e with SMTP id af79cd13be357-93f6f858af6mr297883085a.74.1792750452772;
        Fri, 23 Oct 2026 03:14:12 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e38025da3sm4397734f8f.19.2026.10.23.03.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 03:14:11 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v2 0/3] driver core: fix unbalanced reference counting for
 software nodes
Date: Fri, 23 Oct 2026 12:14:02 +0200
Message-Id: <20261023-swnode-dev-notify-balance-v2-0-948d920a79f6@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAGoz22oC/42NQQ6CMBREr0L+2k9olWJdeQ/DotBfaQKttlglh
 LtbOYGbSd4k82aFSMFShEuxQqBko/UuAz8U0A/K3Qmtzgy84oJVrMb4dl4Takro/GzNgp0ales
 JSZhamE6qk5CQ949Axn52963NPNg4+7DsV4n92n+siWGFkpr62HSan4W8+hjL50uNvZ+mMge02
 7Z9AYYbcyXJAAAA
X-Change-ID: 20261015-swnode-dev-notify-balance-e6f56fb9a469
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Eduardo Ruiz Duarte <toorandom@gmail.com>,
        Bartosz Golaszewski <brgl@kernel.org>
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1509;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=zrXlaeL9N8MVODImAgm9MbC+6h+IDc0akesuGDJ2eXU=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq2zNyFkupV32iqUVoj1WBjC+fBLY9RFjBnMFWC
 XW7VVu8Vn+JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCatszcgAKCRAFnS7L/zaE
 w4e7D/44N63Xe36AQO4g64J2DMWqXw7V7A/eBDcagvc/dCyMNtUYHxrEvKLuZW3OwXAGSyWpJ9+
 ToQpq8o8P4jTVf+oShFfgmltGLKb71rc3KnPF0Eixa3TxKVbWLlKqecWbmBjL0KFn/i8aQOxXZ4
 5+y737dQfpiRAf1RUfT8gTd5JFZCOpchju6GS/tAkQDKuk04Ztte1ET9v4oil3wQktCIhV7LDem
 0RX9ouvu73wGWP4d93EicSOFZDKToZZvqcCDi2F3FojSEhk10JdfftND3GLJcs4S5HWEI5hxUbv
 b1hqQi+BPw8vU4aUoaSI74F2Y0akErUIkpEUpwD9ujc6qUfwe2RBB4JPsDoeZStfGlIL+hrTsAK
 oowiEGDtT+9vE6ucK7NCdzqpM0sHR6DwjqLx2P9uEc61IeZz1Wju/sB4im7/dO4Qolp0WQvRjsy
 mBCz8eTMDyCx/JiFFpyNqRv5lcpSxATu6nRsoSH63r4zGl4zSep3QtXAd0D7hqDCGEljTRsaavW
 HdFYc7JXbxDY6rnQgvvA9cO1GlqWVuBa9IIjIvowjfiGNcXnQJDyeVlKFx/IJUIctzDtLGTCXpB
 dkCxyHzlmpIv4EQv4ai68iON+mnzmfSqIDchj9j8ZEmcXUryOHGUU0WVs+SgfBKOh3aRnPHXu/D
 JRQsYEL4jgCWBvA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzOSBTYWx0ZWRfXzId8IFUo7/L5
 DENnGaccsm1NIc1Lk5fqc2W5FXlvHfbx097r7fmIgksdkAwAAvsQxxXbqpiqeJkn4bSpVB1RbcC
 814YRPkrcvuAQnuvzoZ8oXMMVB1MBaI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzOSBTYWx0ZWRfX1Nsbq4sQ7BxY
 AnEzPlKIXSFTBx1fLfzpOZkXkXx+Qvce2e0q6m+HzYPnytuzaywVMuptm6r9kOx/B3AzLLm9WXM
 TlN7vCr9uqH6WBaNtwsHXGYVTiBDnN+zinLPxwPN09T8eDQbPQBl66dfesU5Se/g4r7MAUuivp2
 YJ7ykKLwFwU7jfAIGlouUYg5hQTunOXy+G7AKn68oxjVfsk4ZoX/vwYKmEpAMZFF+STRcYKkFeE
 k53Xb+eyk3ZeD280uBi8V9GME+qA0EBQhRjK8ZpxNuazwfrhO1bFe4TzaxfMY8/FQrtoGiE2sE8
 adcimW8R5U3upD+iiNTD/rkBhxClmtAdSEkgVCTjTIxbTfG7J2i3iKowcaAeJ59Ag38h1rbp9rE
 aYbzQwXRaJaSCESgDUWs/i5ZqLjhIhBX8fXMlx9hONmbCLGAHsTFcPe0U0PfdF076GWfl+PQfoj
 cR41d9djRM+SdBFcS3A==
X-Proofpoint-GUID: _Fk0l0E9MLjSVXUG28cNbz6Ral1EZn9N
X-Authority-Analysis: v=2.4 cv=YIMKWhGx c=1 sm=1 tr=0 ts=6adb3375 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=kTkK-H-Q3wn9DOHkRvoA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: _Fk0l0E9MLjSVXUG28cNbz6Ral1EZn9N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230039

Eduardo reported an issue with reference underflow when setting a
software node with set_secondary_fwnode() and then repeatedly destroying
and re-creating a device. This is caused by the fact that
software_node_notify() takes a reference to the software node which is
unconditionally dropped in software_node_notify_remove(). However the
software node can be assigned after device_add() so the latter should
only do it if it was bumped by the former.

This series proposes a fix in driver core. The first two patches extend
the device flag API with a new accessor and value. The third is the
actual fix in swnode.c and should be backported to stable (along the
first two as dependencies).

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v2:
- Fix typo in kerneldoc for the new flag
- Link to v1: https://patch.msgid.link/20261015-swnode-dev-notify-balance-v1-0-9e7537bd2869@oss.qualcomm.com

---
Bartosz Golaszewski (3):
      driver core: provide a test-and-clear device flag accessor
      driver core: provide new device flag - DEV_FLAG_SWNODE_NOTIFIER
      software node: fix unbalanced reference counting

 drivers/base/swnode.c  |  5 ++++-
 include/linux/device.h | 10 ++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)
---
base-commit: bd1ecbb61afefc6a8b876ccbc31e9228b44e9eab
change-id: 20261015-swnode-dev-notify-balance-e6f56fb9a469

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

