Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794835663;
	b=d9S2JEFvACgwAHi3b2w3WPgkrCcbSg5RDYJJLBrdI8QXfE1LN3DJf0pSZoWY2ucTdHhJ
	 vCjstYzkYX6W5aeNyBLlDNed92WdxnfXAih5uvnORlWjbe3fcJoOdgIsl/0/rSv8AMZR/
	 Ab70gorTGVr8SRWJoB+GKLac0IY59GLd1/ObsbVKfI49pCn0ElM9rAaMmzGRSus0NHxLI
	 xf0QZizXlZU6BIunMq/FSuMVNVXeyG+cgql4ysqzrAMfgJJG3YZ8vbpqoBR7pkINsOpz2
	 jPAw380ewcdZQanEOKgtUWv0B35ngCX39R6xfyNSuALUF3itIL3j4TJ7vg7XYQtQocg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794835663;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=guvuApfm1WiVp6lOwwVdCibXPFsCHhFXRI8JJuThGKE=;
	b=e4fkn7hhbdR1gRY+EgfseqoPIfITYTZKv6iY5NgAGcMh1QdXngSiSqehRO7U//u48049
	 ceFpCOdc7Kud+jR7vC2QexO8zPv9SeXEYQDu2kvgGeq7rA7W0ReFUkMFDfnuW6+XtOpdk
	 D1CcYC59oG8zu5AbVxrtHXxr/89VRwGGhaFF7p1t49cP7Huw945oflBRi+vn1mF8vc549
	 e/obIbwfKztKmy2JUiRn1/rTKktl6gr6kSBwqBtsF2TUCgjGFlbWu4CFAp1WixySlc22i
	 4Is8tzab+fTGyXYkgLSspWAk5UViGxnTY7B7mso7imu9pBUIoAKsyc26AKa0yQntf0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=G0exRy1I;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cmslQEJT;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3505606A32C
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 13:27:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3505606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=G0exRy1I;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cmslQEJT
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AGC1Gek3117232
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 13:27:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=guvuApfm1WiVp6lOwwVdCi
	bXPFsCHhFXRI8JJuThGKE=; b=G0exRy1I7k8EfQ1IhV7Ysi77z/1Sf9YixnWMJf
	4TLFbn8IpNzsTkfKV4Au0zE1vsgh9wrzGlPgMpSaYvXLVlXvWms8PyqsQJ0JycMW
	jY83XBZdt7IB+lHvLB/VkYcWXtGnVC09xSkqGY6AJ5hUN0vPylBcacO7eS0ODSwU
	qbJ1pBf8c5rLQgJWIClRTiNr3QS43yWBdE4eTnHvOpd6z/VNSSlB2AmXarEXcrNk
	+KhSO8DDS3rTD5TqWU6h1gOxAKsbOPcXVv6+3Arab0mG9vmqATgWK0AzP5zfaIkS
	pjyY/okPECO2pqLnxNuhkXrSux0GWpZ+hoLVuxuzAlAPBEpw==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com [209.85.210.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j01f8096w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 13:27:41 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-862bdb93612so1446789a34.1
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 05:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794835661; x=1795440461; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=guvuApfm1WiVp6lOwwVdCibXPFsCHhFXRI8JJuThGKE=;
        b=cmslQEJThzbaewK3b+vfKwN6WNYPfIBKibGhEK+figyrmhuilePDOvFnZLtyLlayeT
         vDY4rGHd9dP6u0AnAZBsnIAAWofc15SQi31kI61CM4siaJapuj0dI00uhNofwYgHHNWj
         ux5p3gMQqY9R5Cy05iX6dI45HSqdSYWkc+zC6CuxO8WjopYvBFRbGCXN0vet6j8fiV4M
         Z+A8IQGNG3/KoUZxGiN98RTfVpukFlpnc20gpxpASOt6Mr7pcbAvmczh9kqhLjCQHBPD
         /WwZXVf5UFr3RUzN8XOha67B/DsHJw5v6vv09iMRcHmRF464cek8h56J+cuPcpEgiT9m
         3RnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794835661; x=1795440461;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=guvuApfm1WiVp6lOwwVdCibXPFsCHhFXRI8JJuThGKE=;
        b=g5C9J1QQIVdQ55FmmcJkXvENbjMsawvW1glQaw2sMSEIAGGCsDdNPSZzMZBz7uQexE
         wuErcTz+SIcebsPNivlSxByzPA7dM8Tn37dBkm8rK4raRy7jlrP3qsWGk/i6SduLQvQ8
         8V+YheDHQvvUuS/qSquot78BUTPYJvKbB3XkAbDf7AMVIpdIOeZuumoE6CQjMXZFsvB9
         mAdFrRNA59+IUsUIuqPRNs6MorOklcxPhAR0VPN90wAAZ8g/59pecdPd5RyFtWHEjn1d
         EHk6nAqGMtmjRIYb1H+EYqi6plZMHgTyt+gwK4dneeIg1IHr0jF5uj/IIuL8RBCmlN/X
         BpTQ==
X-Forwarded-Encrypted: i=1; AL+hErFMkJ+rXf/VsPkV3r8T0hyZW/nt2dE+aeDcIW2kWfO0nAh4n59cu6qr1BNmzD+3c5Ql6Vx7b8Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z+3AdM7OS5S6B9FGg7guddcHkwkn1CJqH/pqa2kyVEQhVxRS6/e
	2/kN5tqyU0sFe0OU6q+x5BBZjnDSmiaM/7A+DHaMqWjYvA3flGSufHm3tBFNo9QqejoVD1SA4hN
	F85m94mvSe7xQRQKagbEkpAZ6OecLIABIn4POfza+NGXoEfVtDjf8Ih05M8q7KGHKIlo=
X-Gm-Gg: AYBFou2fG55JfaezONKEqJVb9izV5BnWESpisfiK+emIyiT79FaxqA5Hs9eKBnuiik4
	Kg6/0RlnU3Xy9YOfdIbMtsXa1YOKKCwGB5srdq3svt7UWr8kRsfDUjjNGD94HBxe6YVm+/AZ/wM
	HwoRa6fITafUgJcRBN1O9k1e5j/rOkJuRlk8GP356cmxhP/64mqWiYpmd3MPfrTcQNLrKNRYkYe
	mC4ED46nMEtByIJrLW+T5nVzKU6G8sj4uf9mczDV2rvaq4pbGauEo8BbcF/CkVCyvbsncnbGYac
	pLxxubEoCdPwpUvT4m/4cpnqU+YT92Jv4O7Ah0gqit51+8UeJ39jW2nLNxR1z/PZ7d2r8sO45m2
	bIor+4ZKVC70qoGclhNFei0sdtPfZya1NMy3XwlCWWIzd9SUyeCzLe8RCJldv8sa4DxuqJxCHBZ
	h4HktV32Y=
X-Received: by 2002:a05:6830:2316:b0:862:b733:c7a1 with SMTP id 46e09a7af769-862b733cc47mr3294273a34.14.1794835660747;
        Mon, 16 Nov 2026 05:27:40 -0800 (PST)
X-Received: by 2002:a05:6830:2316:b0:862:b733:c7a1 with SMTP id 46e09a7af769-862b733cc47mr3294260a34.14.1794835660295;
        Mon, 16 Nov 2026 05:27:40 -0800 (PST)
Received: from hu-vkatoch-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8628813346esm10012527a34.17.2026.11.16.05.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 05:27:39 -0800 (PST)
From: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Subject: [PATCH v3 0/2] fastrpc: fix probe-time races between rpmsg and
 userspace
Date: Mon, 16 Nov 2026 18:57:29 +0530
Message-Id: <20261116-fastrpc-probe-fixes-v3-0-3cd56d9d9a93@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAMEE+2oC/22Nyw6CMBBFf4V0bUkfoYAr/8O4aGEqTcRCBxoN4
 d8tuNAFm0nOndxzF4IQHCA5ZwsJEB06/0wgTxlpOv28A3VtYiKYUKwWklqNUxgaOgRvgFr3AqS
 SNbyumCkYKJKaQ4D9kYrX25cDjHOST7+wczj58N6XI9/SfYQzxg9HIqeMclmqtpamMhIuHjEfZ
 /1ofN/n6ZBNG8WfSohjlUgqrYy0yipRlPxAta7rB1+phLcdAQAA
X-Change-ID: 20260923-fastrpc-probe-fixes-30c1980b50e6
To: Srinivas Kandagatla <srini@kernel.org>,
        Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Escande <thierry.escande@linaro.org>
Cc: Bharath Kumar <bkumar@qti.qualcomm.com>,
        Chenna Kesava Raju <chennak@qti.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>,
        stable@vger.kernel.org, Tyler Baker <tyler.baker@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794835655; l=2067;
 i=vinayak.katoch@oss.qualcomm.com; s=20260609; h=from:subject:message-id;
 bh=0hSbXEUHWhOnAJwHR1KYQ1+mIhj4JPQ+AgjXU0arhKo=;
 b=17vbNjqF4I1i1d38v3E4MmjngK7pIy50QiuIVJTmoCgg906g5vHwhP7znbye0X+F0LKim2bfn
 MUbmFojkzarC7ArQU4KIeGsPKsaDz7bY5knBTZSO1udOMn6nsPlASpo
X-Developer-Key: i=vinayak.katoch@oss.qualcomm.com; a=ed25519;
 pk=UrGeKKxjIjpHZIjsbQKS/8rrVaP9KVGki69pFclCH08=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA1MyBTYWx0ZWRfX9xXbkavIWKej
 UfMvZiifScQoYX7uWCbtesc79ZKBcqLjUHhxrboZZjWYopmDvBgvMJkNL47urHnwA+zmAvZMbZx
 zADmLad3HEQeq6m9UW1pjoYPk7Yf0icAIr9xeY67uno6m9TzydMZX8ne643kNN+cZ8zaLfJ3z3r
 6ms9Ax6d8AmX9I2z/0SN533nXFMPS+D50tlre5HCDForqRqyEARRtWlbW4vphdvRAnOhjjesdvX
 wNjXeRz12jRv2aCMAS0aU9+cGJbVaEimQq56fyQoGdYf3TYQiYTPgkARBpb3LYPx1Z97YuZOuNY
 lBki7zQYZeI94aLfIfX/Ym+dJ8tXKxsdcfJHnLv7z/wgJNnGcOSFdGNomRUBwO9gyb6BhU0SOtS
 /cZQhGLgzQsln4zAMZsw8ythXymAHiz2UC3m24YRz9o7HoSF5YzasLDAawG+1RT863pB3onLRMP
 dS/KKiCnvLbFMl8qn3w==
X-Proofpoint-GUID: nqzuZMnl1r3pP0Z-YrvWN6JPYPMhAxeM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA1MyBTYWx0ZWRfXz/+WIER2hdQY
 T7t0Yg48NZQ3sAUal866uolXT/k+6N82NzYfPMUAbraKVQOsAEzKy+W7O3pl+LwKlNx7QBlhaOJ
 VXSW/HKP/I3GQDdlqsluSA6cNdG3rvI=
X-Proofpoint-ORIG-GUID: nqzuZMnl1r3pP0Z-YrvWN6JPYPMhAxeM
X-Authority-Analysis: v=2.4 cv=VMpIDNPX c=1 sm=1 tr=0 ts=6afb04cd cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=BKo7ZjnSzHxpABjNsfcA:9 a=QEXdDO2ut3YA:10
 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160053

This series fixes two races in fastrpc_rpmsg_probe() that can be
triggered when userspace opens a fastrpc device node concurrently with
the rpmsg probe sequence.

fastrpc_device_register() calls misc_register() before the channel
context is fully initialised. A concurrent open() in that window hits
kref_get() on a zero refcount, and because of_platform_populate() has
not yet run, sesscount is 0. The error path then calls kref_put() on the
saturated refcount, which kfree()s the channel context. A subsequent
IRQ-path fastrpc_rpmsg_callback() dereferences the freed spinlock,
causing a kernel panic.

A NULL dereference in the fastrpc_device_open() error path when
cctx->rpdev is concurrently cleared by fastrpc_rpmsg_remove() is also
addressed.

Signed-off-by: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
---
Changes in v3:
- Drop the dependency on the dup-sessions series; use
  of_platform_populate()/of_platform_depopulate() directly in the init
  ordering patch
- Fix Fixes: tag of the init ordering patch to 965602eabb57
- Rebase onto next-20261113
- Collect Tested-by on the NULL rpdev patch (unchanged from v2)
- Link to v2: https://lore.kernel.org/r/20261022-fastrpc-probe-fixes-v2-0-a6b3f6f62571@oss.qualcomm.com

Changes in v2:
- Add Cc: stable to both fixes
- Free cctx via fastrpc_channel_ctx_put() in the probe error path
- Clear rpdev and wake pending users there, as remove() does
- Move fastrpc_notify_users() above probe
- Link to v1: https://lore.kernel.org/r/20261001-fastrpc-probe-fixes-v1-0-1376d93b8b3e@oss.qualcomm.com

---
Vinayak Katoch (2):
      misc: fastrpc: fix NULL rpdev dereference when session alloc fails
      misc: fastrpc: fix init ordering race in rpmsg probe

 drivers/misc/fastrpc.c | 94 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 56 insertions(+), 38 deletions(-)
---
base-commit: 84abb955b1015477aa11a96e2f3ac1b938b77f48
change-id: 20260923-fastrpc-probe-fixes-30c1980b50e6

Best regards,
-- 
Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

