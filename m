Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794305445;
	b=vTYEfcGkuERLlclf+9T4+0LMsqvZLIEY4ZsGipiMR+k3bmNij5l3J2JxbrHR+89ABAut
	 Gs9G5E51f5JKptoYIU20aFo29PeTr1VhV2ZiIr48LwtaGd8PDcx5y4pjA0m4eV+kCh13z
	 ljRGvaPMiscPGu97aWYxTDO/6hQKM85ie+kFBUOzunMxZNFjAvHxunrq+tKLLo1brO4G5
	 SkdS8iv4cUt3OE8hgJ/AKq8qgeFCa4gWfp2eCA0bc1qwaNccYJ85EtjM5TRNeLksu1odT
	 74MEe64a5j7ffhe60Q/gL7tr48MOaT5ehPHWm8bV7SW1vYYBvecplRS7gYE1epn4zKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794305445;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=77tgSSo7L1hMEDBWl5pe9JZcxH3eLtSx4Ca/ATuyomI=;
	b=j8FKR44BQS9JRhYTfUE6wlbyxw9VsivFdZ26frO+qhSOJNJJRG/WaUHNRn84OR5S1+6w
	 3KJr37bim3X+BSYcWlWeiCKqq+omyH3T6FhMU5SE8vAtX9LSAfEGbjsHdN2gOFb3LTWCY
	 7xst0C5ELhZRcnuFpz5dFi5LXNMK2C+pE70N3l0+2h9J0Ds6eFP7B8XQ7HOCGrh07fAAg
	 uAqLjRdK/ymedQ5j6OhCwBkR2r81qMIQnoy67ahapwd4KW9e4EFfupAx+RaEsjWj8B7c1
	 VoVpgtJyy3RX/ersx7h2Lyoe0zWK1aPH8Y+5N9uyI90MzoGBZmBovEI5JH3c0LIPOew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ai9OjkbJ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jyJOKIsO;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49809606B51C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 10:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49809606B51C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ai9OjkbJ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jyJOKIsO
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA7klVr2779825
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 10:10:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=77tgSSo7L1hMEDBWl5pe9J
	ZcxH3eLtSx4Ca/ATuyomI=; b=Ai9OjkbJrom0f88Hz8o8LfS+ZBtMldPDJ4eiGQ
	1JlT0noO0e6ZCN2xXgSPGmzIc/gDp9qcQIeqouvgoZkknB8Yi6QA2IOQF14Oe8eR
	orQLQxBFxBz0saM0MU/3To9XuMkSyaverpbmCHv40gUY9xABRRbFNeg9dmtndRsW
	IdQRMDTREwULML9G9x9Q3P+KrK/KDn7XaMqY9nIa3bUFsoMc547gv3jG7ddOgV4N
	ZUxnyGBTEejrM6CXcpDrtHyxGHVGR7Cvfd+UrrJRkNuEYAFkZeMj0DBTWk0V5gt7
	fCSGPK0UovqjTl6obDU3v0H7ZP4qK+8Z6ZfkIGtbnCXe4bvw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huy5d8jbx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 10:10:44 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93909014c85so391616885a.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 02:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794305443; x=1794910243; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=77tgSSo7L1hMEDBWl5pe9JZcxH3eLtSx4Ca/ATuyomI=;
        b=jyJOKIsOYrKppLmqx8eTwgNSkhi2qRQYlXRq+Ja+Z+8D3Kvbt2vwzLQTBEfa6xXadt
         fwhHc3y7ZEbGDLRbe5ucyuywr63EYDL6WNZKchHdE9CPjfKT9W0+1MdkSnpC5PFZ2Wdp
         rCNB2yvNBytFi2jtQfxnHoT1C4R2141ChefLRSvtU+82tLIrPM5eusvIgXLpia6wx7lE
         pS9gkrrt5CT/OSAOy+YngtgiARBnKEvP2m1ySdfvVcqIUGNcBodP4FojDZe3rw8tKhmb
         nJMiJgmzAc8vpvSEu8+W498yCAh3sBICYgPbYgwVRbcri8R15Dkc1jBY+NC6InCqF6/Y
         ZHrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794305443; x=1794910243;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=77tgSSo7L1hMEDBWl5pe9JZcxH3eLtSx4Ca/ATuyomI=;
        b=WsIAZI6cumTgejQyzvhck8wJeFScr2ejknEsfFtuqYD+k+GwdElClgNrT8lDjxZHUx
         x8En1vRk/3aUkv8W/weB9ONUtbWxn6I7weQ6zZbkIfCVjY6H8tWDjbvbZR7T1lWiBg9Q
         H+Cg+R5MgY+LHfy4t5LX7LxvuH2yvn3AnjBz2ieGupxqGXgwFGQyKFRiN8IcFcOPUBDo
         V3c1YI0sdUy9VgimITvmmxU3J4eYsie3K6udX66n8yufr/dp99t+p1+eWBkiVWTJBQCY
         ZNCoz5cD3FqFFyfWt4CK79m6YKzmMo7hELKT+qhQU0QDY7/6DR2waDP/R76Cq5bxFZx7
         pMAg==
X-Forwarded-Encrypted: i=1; AL+hErHGYeDrkZs5/lK/C3MCSLGUasZ715W7HNA6uIVo1Bpeg6SQFPtjqUUX4PvKD4nJELofjWPrNGc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+01CCz4LFqDO+F2jI/hRCNwVbv6syD2hAqsFLmjQjmVknMDAx0
	XSoQW7x4QC4E9axTd8sg7h75rnkOQmEJcTKYc7xsPPIpesRhBnGp4V0kZ8XzAsSlhnt8T3q5sb/
	ltSHBfKogpPo1yRS9VVZZECXmoPz8iajNJ5t8Umq5qK1f5xAZ8RSSaVRh10Y=
X-Gm-Gg: AYBFou3mTCj0zwa5+t+4Pkm4sa5LEYNqhXMfGIX26bbGbNvlvM2rulwmPTKta1OBuv7
	B344ra4VcMwoJDhApyrAICDPjgTHMIZ6sDAu4n18DNQdH+BVsyqwvAaLHnKsLWghGIfWPC1BUVO
	4ajIt0QK0OeEu2nwWcteu4e93aGX1NdugrsG0xA5y+KxLGTnSoZ5t1y9Oz8MxjkhP21JBRwmlq8
	yZOF4J9cLP+SMRn0VTpix8yw3+x8vP3p3RSKP923OBPqfSC2fxWcooWAJa3tr3ckhf6Zheio4Am
	rZMbi2IMQsGeUThygoxqF5wzA38MwYgbW7UTzT3pC4O27624LrJeqZngzf4sNhoomXQS7sdi7cX
	eY8UZWxMNFCl3BJi4CmdwbeCjZlZ3z1iOQuB4h+reh82BYW662GDFOqoTc/EaNj9v0ITgx5jam4
	fQ1wNhtU9fE+K7Lul2FQnyf9VYSr2qn2pFLCSdjhpalnEQRFrmB/L8zNWQMtO3cXg=
X-Received: by 2002:a05:620a:4593:b0:93b:e5e9:23d9 with SMTP id af79cd13be357-9479f2b00e0mr360761885a.23.1794305443429;
        Tue, 10 Nov 2026 02:10:43 -0800 (PST)
X-Received: by 2002:a05:620a:4593:b0:93b:e5e9:23d9 with SMTP id af79cd13be357-9479f2b00e0mr360759185a.23.1794305442947;
        Tue, 10 Nov 2026 02:10:42 -0800 (PST)
Received: from brgl-qcom.local (2a01cb1d00dc7e0089167b9b97a26c96.ipv6.abo.wanadoo.fr. [2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba02005946sm60806145e9.1.2026.11.10.02.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 02:10:42 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 11:10:40 +0100
Subject: [PATCH v2] gpio: shared: fix a race in shared desc release path
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
Message-Id: <20261110-gpio-shared-refcnt-race-v2-1-8a0b76e01714@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJ/t8moC/4WNwQqDMBBEf0X23BU3oGJP/Y/iISZbXajGZlVax
 H9v6g/0MvBmmJkdlKOwwjXbIfImKmFKYC4ZuMFOPaP4xGAKUxEVFfazBNTBRvYY+eGmBaN1jKY
 j9p6d9Z2H1J5TKO9z+d4mHkSXED/n0UY/9//mRkhYN66hqi6L0na3oJq/Vvt0YRzzJNAex/EFr
 s61z8UAAAA=
X-Change-ID: 20261106-gpio-shared-refcnt-race-2b1eddecadbd
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3255;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=QaT0N6QSxoOILYgCk8Ws3mmu+/8EWOZAz5V+a3NkPs0=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq8u2hE3WJd1FvW84yHPDr89QnOd63EJ+lkoK9c
 HqQ7Y/FeNuJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCavLtoQAKCRAFnS7L/zaE
 w4m5D/4j2EuA/eXow0PzPDW2JDYR7dCQHSbG74xkQ63GruYbpTgfDh5yckA+SlP9aWSBuSflU3r
 Wnb+3Qt3EWboR2T2swdDoH3lgx5I5X3okdYXBJ1ugtg/6Tb1UiT8/2wuskj+fYAqSgjZsjaam4G
 AZuGMg7fIegBiNS2m/x//sjaBV6KJVEgpbmmuHKzo9Pc5OTgkMc/CAe7moVQx+eCqvX+XdrdxGN
 /yns2LBWpsWqzQ70IgwP8DR/58Kfn0ieUC5TpqwV++8IGJFoOtMhLG7XH4GTAhCF05A6N5gCg0l
 tN1DO+zF+7xc9Q5oZ2rJdeaCl+wDrdepZmmULY6GwjIMzeo2J9GhU1ZnuwmES3j8G8GKJ3g9cYI
 ORwVPWbEoJQkOlnwPtHB8OY+bdyNkXrC/0LaGX7Trjy2ylktumF/hfmp2wsxZQdg5/1tGnLdu6L
 n9jpQikPPkUsEnY1dmwrtngxdEYdPEZ1A44gZd1EBuk55C42roO0NArco5q/Fmi2Vux/Bp89i8e
 0DItXq2cOIcC9/L7LYqt7WJ0DsvhU3F/rqryutsfy9S6zbe0k1p2LYqhPlCQvhHmZyDXU9P27he
 vOJG6krIKys0YZos1a2ATtjSqi+4iULf+pMYcjewC86JzO57jja6KWtqImghZgXviakWfOC1uD4
 +blPwa1FunQl3cQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: cfC6-BUrOpdm9eFyAxPegEpNc5uW2lFQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA0MCBTYWx0ZWRfX8q5K0AOvO4dF
 pXw3O8gTeXYrZLbw2JmJDnFP0eJekZij/7PQJ3wEx0yAW1md3Z47dN3lloMQfIhf+GcQEy8YxAc
 oPsIvNv4AdUVgLDUkRtPizj1R8fSzVg=
X-Authority-Analysis: v=2.4 cv=d+9gWhjE c=1 sm=1 tr=0 ts=6af2eda4 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=c92rfblmAAAA:8
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=oU7bRusk_2LGITF8MfoA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=GvGzcOZaWPEFPQC_NcjD:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: cfC6-BUrOpdm9eFyAxPegEpNc5uW2lFQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA0MCBTYWx0ZWRfX1WKc/64DBr0G
 noij6Voo9Ks59Q5Ww9onpSWiXmxyM84kKk6c6u8mOLFdF/OKlGpl5VQp+qxRjIg/iJJIvhWtuHK
 Ftp7pvbIWM6Z2yZ3EuMCdAUCKnfJdY2QG/KswyCOHjhGQRN6mk/lFrTGz9zw204gjIlp1AFQG4/
 AQq7Wusy2aitU538mGZvI1FdcC2VpO88X0Kbt4kkeW2ptv5R21FyfypmTdMKDkC35BFod2knPz/
 gEdhYg0DnVsIbTDB6hNaIK1OWVkzH9Xbv/ObsiwGxdpxcO0kON/W/L3Zqc5yoX4XnwhmAQ+WgoT
 P1gmikX8a9EHi2EOMfk7M3qgedCEGckS4XKVrSMcFpGmVqMYKQLW8cFERDfKSviblBvYgHUWHWo
 0pjV1sKIh8PMlsfzfJt5o9tq8csDRcBmXyjzNhsBsxAh9KsuRw6s1dkk5stB9sTfuO4OVBmlu5j
 wl/hxOjvzqNFrkyfssA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100040

gpiod_shared_put() races with concurrent calls to
devm_gpiod_shared_get() like so:

CPU 0 (unbind / probe failure)      CPU 1 (concurrent proxy probe)
==============================      ==============================
gpiod_shared_put()
  kref_put(&entry->ref, ...)
    refcount_dec_and_test() // -> 0
                                    devm_gpiod_shared_get()
                                      mutex_lock(&entry->lock);
                                      if (entry->shared_desc) {
                                        kref_get(&entry->ref); // on 0!
                                        shared_desc = entry->shared_desc;
                                      }
                                      mutex_unlock(&entry->lock);
    gpio_shared_release()
      mutex_lock(&entry->lock);
      kfree(shared_desc);
      entry->shared_desc = NULL;
      mutex_unlock(&entry->lock);
                                      // uses freed shared_desc

Because gpiod_shared_put() decrements entry->ref without holding
entry->lock and gpio_shared_release() only acquires entry->lock after the
reference count has already reached zero, a concurrent call to
devm_gpiod_shared_get() can acquire entry->lock in the intermediate window
and observe a non-NULL entry->shared_desc. This can result in a
use-after-free and a double-free when the second consumer releases its
reference.

Use kref_put_mutex() to ensure the entry lock is taken without a window
in which a concurrent user can see a non-NULL entry->shared_desc while
it's being released.

Cc: stable@vger.kernel.org
Closes: https://sashiko.dev/#/bug/linux-30e071e4-4e4a-4b63-bd83-df1147055d35
Fixes: a060b8c511ab ("gpiolib: implement low-level, shared GPIO support")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v2:
- manually release the mutex acquired by kref_put_mutex() (sashiko)
- Link to v1: https://patch.msgid.link/20261106-gpio-shared-refcnt-race-v1-1-79c9167505ab@oss.qualcomm.com
---
 drivers/gpio/gpiolib-shared.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpiolib-shared.c b/drivers/gpio/gpiolib-shared.c
index 8c9ac9d9330490b17fb3936b8758beb97a308a15..edb04a5bb987e12faf96e5b70198a9fabf60ad0a 100644
--- a/drivers/gpio/gpiolib-shared.c
+++ b/drivers/gpio/gpiolib-shared.c
@@ -635,20 +635,20 @@ static void gpio_shared_release(struct kref *kref)
 		container_of(kref, struct gpio_shared_entry, ref);
 	struct gpio_shared_desc *shared_desc;
 
-	guard(mutex)(&entry->lock);
-
 	shared_desc = entry->shared_desc;
 	gpio_device_put(shared_desc->desc->gdev);
 	mutex_destroy(&shared_desc->mutex);
 	kfree(shared_desc);
 	entry->shared_desc = NULL;
+
+	mutex_unlock(&entry->lock);
 }
 
 static void gpiod_shared_put(void *data)
 {
 	struct gpio_shared_entry *entry = data;
 
-	kref_put(&entry->ref, gpio_shared_release);
+	kref_put_mutex(&entry->ref, gpio_shared_release, &entry->lock);
 }
 
 static struct gpio_shared_desc *

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
change-id: 20261106-gpio-shared-refcnt-race-2b1eddecadbd

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

