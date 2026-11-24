Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.139.74
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795558112;
	b=tUfbwqAFrv223/XzDvfJc+n74zIDUGk5GT76c/w8ksKdsNXai+K9bsjTDlKc/c1LAJuF
	 L5FT9XaEjHWUq9gujNOIDqIdtKY7bgAqwm8TitmqRxnMWIq2NhIUhTboQ5NtNnsFFhyx8
	 h7LP2cu8NUbOU1FYD8XI5PluPMeq1aspv19PQI+Zf4lJCxtPjaWkdnoR5ktH6POROBWES
	 7G77Gr3g9pKJU492k1aRVMriWs+bwClw0JvdNneyCaeGkXYRtx8h0Q/gb+XJNBadKYs1U
	 hnPhlrwQj1gB7/5eGhEF9YZ30Z2GfPmLrEkuzWV0Fl45fc5oa7mLU+3zzpFiIj4C0DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795558112;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=wUd7P3Ye34O3sWY6zQup7AwNcEoSACo5n0ZnarzR1XI=;
	b=KixWNeNqaBeYiu9k5LZ36kcUDYM11UvllgeGl47yUj0zpFcdWKKwmsiWamko/w91zmeZ
	 6sAESfKVQDH4+r8NuqXTCVHtepQlmhIsEry4pUhuaBW8e/k3O9Ye0UjsCQ/SJutm0IuCp
	 M3G2G2u17uq0n9GrWq3wY7qfQNJvDS1xGCBpgustrld+A3wNGXeluMYuzOdslrl45FsqN
	 VmAON12ODLRI6yS7gHcD9ZBuLelWlpDiIF6rXPZEmlWl4matBOmwJr4s3hC75zZaHQIE8
	 xtl/6Z09iFg9rs8MCm/oSGtZDrlX1AQiydrZ7vsjpPlqdt0kHLtqjhk+Dm+MiV07QfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=columbia.edu;
	spf=pass smtp.mailfrom=columbia.edu;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=JFArw5gx;
	dkim=pass header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=cpKA93ld;
	arc=none smtp.remote-ip=148.163.139.74
Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76019606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 22:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76019606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=JFArw5gx;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=cpKA93ld
Received: from pps.filterd (m0167076.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOLXMOn194860
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:08:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=wUd7P3Ye34O3sWY6zQup7AwNcE
	oSACo5n0ZnarzR1XI=; b=JFArw5gxspepOPID2sCILSVWBL62zA1klYsJ7L0s3j
	mOyS6r4fCbJwPN8phjF0SlzHJuEJSmCK4NCDrWcmZiodznvt6H9U3enfhyLB1BBt
	GMeGTESD6Lu0s7Qe8VxZtF58mFV+ragHiqZ4UG4zd4DocY88bbIwY8EZbM8sod7b
	tfgD+nSrMRc8NNO1aHJJN8vO4B74oExHRrV5hhuZMlwzv/dGBzdwRfh+TKIDQFQ2
	9k7HanLce70Lkg9n9hdGqFHcbaZOH7w0Dq0pKOqQDXtVfiz0XOQsTRMxn7l6nK2f
	vo/0I48irWi0iRqAW5xUVY184z+oZUxe50sCqQ8ViawA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j5dsc3bn3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:08:30 -0500 (EST)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-9213237a52eso89752486d6.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 14:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1795558110; x=1796162910; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wUd7P3Ye34O3sWY6zQup7AwNcEoSACo5n0ZnarzR1XI=;
        b=cpKA93ld8v1LZnPqOyIfSem64jpgWC0h+R2fzejK1ynoPZg3MapwXMFWB2KgaLxJGM
         Hm/h0WINz9LX9qtOINdHoY3FEz5+/VwC+MAGo4vpHf3OMAT4XRcq4fRV7B4ePdq1NHzJ
         2qq1SpWkw5oJ7Ls8EmmdUJ0wqXbhgFdz50SCno88c4UlIGyUbtM82unY3qxEVaD4fMlz
         Ko7z0Zv5GYuwXMVXfKh8z5KsGsKwTVmax44VWYgTyLrNC+ifp75KEMJkg9h0W+rTgVoL
         jH06hkEtz7sQVON5uCtz2JDX9oz+f5BQF1++crDoCRVgQMwis6ljyY0jImGdmuCUnGuL
         NOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795558110; x=1796162910;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wUd7P3Ye34O3sWY6zQup7AwNcEoSACo5n0ZnarzR1XI=;
        b=RNwJpmSGLlMfdfZ6u8CIlXhprM+Rncq26RPiQz82rpgk3KqPfAHFRYazEFOx5EEDU9
         PO0iE0oHsRgZyMTWIBpwW1kRQU8rhCieQnioBIoGyMCxhZJ5jgR6WpXE0WGdf3Rv41u8
         k+pSO5uGrey5OZPogAxLHIjluG//cysR+8MhVVJz2dJfGZVGtSi8z9xI81bKKb7AgonA
         p+aR81d8+zlpWjW4Km65OmoisZcwg8rLrlLgOW2rNckpHePwh/WjydyxzSrTqy3vHIKA
         4JAMACB9mwGHybWvJfYqxIHur0l6LOVQjqxfE0yaNuYm+UOjGgQebghUVs5LdCga7+aY
         58xw==
X-Forwarded-Encrypted: i=1; AL+hErHaidpPvEuMBHLC4Xpab6C4xxfLEOVHtm6ax8lH8vCbPiKCB3ABaCW2U1JuwBrszBhERulzGDE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/po3dOd1yzOoqaq7OUySBO0tSrPAqG+C9B75Cofy7L4UMx4VhI
	8sBg96ts6a5+b+DRbsBLMm3yIeYfKg8xoXGpls73RXmVCHssB8k57JpjMczK3seioVk3f6VA1rH
	fV2Mw7CYaOEvS2LLYn/dJjLzEvGmMdeWQazOX3p/y292ggy+B826eBQ==
X-Gm-Gg: AZFdTZdQ/NxHYy/EFeeywoEScQDb7ch1k9RFaRf7Lk3LWrIlToLGvFAUxPUC1LibDIA
	4k337/wwAe3eRFqltFLcuBAw/LGZXBmpuDUXlLctNfMtaAU6As2exZEiSgJZAfYNoaun0VUoF8D
	YsTpGw65773D5czDvQwDG5qhUoC/5tOUWx/YOKMOuKAp2Z60R+RzXohwV9N9a3/OvWMQ5ulR5PC
	NnINutsvMzx6GoAJG8MPilz9Hf52UtQ0t5vFGZmV8OUVl/lrEqPw2CNftw7TLpMNEj95pI/joAL
	snRcL6fxHCOnspnGOARQwh8Fbdsmo4TL8DEluNqUk4edsSTq9TmRSjLLFqI6cbHazmbs5AI37Ek
	jO6z2CjTYjOy4zvQSi81bp4TNTaTNZpToPU+XqKIlMVksgOQIC5XyMQRATHc=
X-Received: by 2002:a05:6214:458b:b0:917:bfa7:2598 with SMTP id 6a1803df08f44-92134aae4damr283166436d6.18.1795558109766;
        Tue, 24 Nov 2026 14:08:29 -0800 (PST)
X-Received: by 2002:a05:6214:458b:b0:917:bfa7:2598 with SMTP id 6a1803df08f44-92134aae4damr283166086d6.18.1795558109408;
        Tue, 24 Nov 2026 14:08:29 -0800 (PST)
Received: from [127.0.1.1] ([129.236.231.128])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349b3a0csm144944586d6.14.2026.11.24.14.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 14:08:28 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Tue, 24 Nov 2026 17:08:18 -0500
Subject: [PATCH] virt: acrn: unpin the interrupt monitor page when
 destroying a VM
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
Message-Id: <20261124-acrn-unpin-monitor-page-v1-1-097458800936@columbia.edu>
X-B4-Tracking: v=1; b=H4sIANEKBmsC/yXMQQqDMBCF4avIrDtgIo3Qq5QuYhzbEZyEiYog3
 t1Ulx+89++QSZkyvKodlFbOHKXAPCoIPy9fQu6LwdbWGWMN+qCCiyQWnKLwHBWTLzPX2P45tK2
 rQwPlnZQG3q7y+3M7L91IYf7n4DhOEA6cy3sAAAA=
X-Change-ID: 20261121-acrn-unpin-monitor-page-632d5f7760c3
To: Fei Li <fei1.li@intel.com>, Zhi Wang <zhi.a.wang@intel.com>,
        Shuo Liu <shuo.a.liu@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Reinette Chatre <reinette.chatre@intel.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795558108; l=1265;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=H8wehEAUOYpvrHyb1qYk3+1cUineECJ+mIJ3t8JdECM=;
 b=byMqRJeO06XTgFeiumRYTldhQ5lhm+UaD14l657W89Gzqzq0DYteCj4m4uGEgSHVhs89eKLg7
 Qz/fKrytaDKD3CcTN2ZwajcFVXFA0RLsAwD4XzsAjIIgU6q2sb3PAG1
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA4NyBTYWx0ZWRfXz/YBUlaqVi6l
 vjdIxzUeY2NZ0W6vhvkhRGDBoqXhwiXbJHZdo/DV/Gf4/GsDUK2HhA/dui9jGxpWhFxPKV4qkYc
 WO/mE5zULo2iIOm5C0yUFjzfCmQwhJ8+FrGvde+BZfxMSI8tEVe53KV8Iv5nR6wWzVJNdFgDWTR
 NdtltmNR6FJZO7VPN72hhh8AoFVMxqYUnBgIGAzy+8g5ZBzuexNEL/xBWgM6i9ozAPfXflISBwu
 7VZjii46YeSAcpGgJvRcNrgrfDSf8cBCh+5xwwk/eSZOqS6WUV0uHRnRhEAn62XyhLSnsJwDOU6
 DkQNWFSiUzjPHrHjA9b1ZVwX7pcL2fdv+uER0tkqizBIVH//qmYQ+TVRRBncB6zvRIO/uNnJzFC
 NUjvKWuZpUxuYWDyIoUZkRMvGpa1XYUDVR+cSkIfy1j4ziyb/Y91zhSNZV4BLFyWfY3OZl1QyDW
 pM0e/XRSxQrQ53XkNKA==
X-Authority-Analysis: v=2.4 cv=de4VTnXe c=1 sm=1 tr=0 ts=6b060ade cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=LNQXEAmb7IHcZyFqmLK0PA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=Qm0qsxP7aFY2tkT6R2MF:22
 a=VwQbUJbxAAAA:8 a=vjun-3o0SPL4aK9ehdYA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA4NyBTYWx0ZWRfX4QzLez/T4dEB
 GnkUHgvrGLbhjQ4pZ44KQWzzAEn6/CIs8MuvTh2PWlfHGfFbwVkFyLY79oaqSOKFYvJm0B24mL0
 d6Gy4vDEg2TKxoOt8W+NA4NNI8lziOBwcS+vTNSCa1nPRujWWlGl
X-Proofpoint-ORIG-GUID: 7ISjcpEcbdegquT45tHQq1CpwQlTvirW
X-Proofpoint-GUID: 7ISjcpEcbdegquT45tHQq1CpwQlTvirW
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11976
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=10
 adultscore=0 suspectscore=0 impostorscore=10 clxscore=1015 bulkscore=10
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240087

ACRN_IOCTL_VM_INTR_MONITOR pins the page it is given with
pin_user_pages_fast() and stores it in vm->monitor_page. The ioctl
releases a previous page with unpin_user_page(), but acrn_vm_destroy()
releases the last one with put_page().

put_page() doesn't undo a pin. A small page is never freed, and a large
folio is freed with its pin count still raised.

To fix it, use unpin_user_page() in acrn_vm_destroy() as well.

Fixes: c7cf8d27244f ("virt: acrn: Introduce interrupt injection interfaces")
Cc: stable@vger.kernel.org
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
Compile tested only.
---
 drivers/virt/acrn/vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virt/acrn/vm.c b/drivers/virt/acrn/vm.c
index 3753b27c5312..49643dc52831 100644
--- a/drivers/virt/acrn/vm.c
+++ b/drivers/virt/acrn/vm.c
@@ -82,7 +82,7 @@ int acrn_vm_destroy(struct acrn_vm *vm)
 	acrn_ioreq_deinit(vm);
 
 	if (vm->monitor_page) {
-		put_page(vm->monitor_page);
+		unpin_user_page(vm->monitor_page);
 		vm->monitor_page = NULL;
 	}
 

---
base-commit: c44104f3642da720164042623e4832836aefdd8e
change-id: 20261121-acrn-unpin-monitor-page-632d5f7760c3

Best regards,
--  
Tal Zussman <tz2294@columbia.edu>

