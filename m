Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DACF4457D3
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 13:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786974955; cv=none; b=hDmJgF89XOdClUNFqQMp2/8rfi7Z21rxIPys0d25j0+i6qbAJONqaCFyNjeQQU2Tm/NtmoK53bVul2+eu1f4g1UR7oihz60clbGv+CdtbO7tf8axAxFjq89hGQ97sar9dAGxNHXZL6gXcqAS31c7LnJvdbF+0V8iSQxnN06QgB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786974955; c=relaxed/simple;
	bh=qCQ8QwH+/ilnK3pMvAgG+RA65ORehXDT+fzjCM2bcU4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gw61dcxFDYCwyjf3d2aNxCMn/5JoQkoWKntgKxoJJRFA8/Sth0p8DOaz79Y4XXAiN30BXuO0z/TNzdWG5BGeeP7lt48hHIY7v0mFtoWl64aDTqxbsuGKmlC25XT21/Uul075SCTqW5Xj0HIOBayp4B7jqIiCTOgWvbkGbDMg2tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NGAMk9Ah; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YJQV/S5X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NGAMk9Ah";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YJQV/S5X"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HD6Jbt2431653
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 13:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qCQ8QwH+/ilnK3pMvAgG+RA65ORehXDT+fzjCM2bcU4=; b=NGAMk9AhCYvhd6/1
	ab1yLILi7s27Ki+LQKfUqY7aalqX7rxeP2WceBYTiby0Y98LrTP7jOQKwQ58u4wi
	VNmz0P3b4rQzjTt1pttD2JHu9q0hiKvqBR8Y/i4kaNBn8wnLGZP3rRwGbpLLKBGr
	7CYo8lYSM7n7rKlnNGmmZFEyIMlSjMfl2+25dMPKAthINGsdbx0yAdqLeIxhnYzo
	M8xxajJhZOUiNaebkutrVgI+e/udI160Ycf4jsMpj/Nyj0mtcpxdsIGSY+BlRPiQ
	BRVymtze8EOo7yKyio7A+8Ayl4M7a2FEIzdRPoqvaU8WX/2wQJOyZsz2BC6xmi/E
	CC/Q6g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3wrehhdy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 13:55:47 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-90520763ceaso10781446d6.2
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 06:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786974947; x=1787579747; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qCQ8QwH+/ilnK3pMvAgG+RA65ORehXDT+fzjCM2bcU4=;
        b=YJQV/S5XI31rjkHmKykOisRnZkxskUt9+d0BIFZMA0RskQauKmAnU16dZs1blanWDh
         rKivuPTGaQUonNG7frvkoSVQ3SiafG5WZpk8wSKt/7C3UQK83Isx4PnNYPIbiw+U63w2
         3BkpFCnzKz9MiFy4FEDTY6CvUAUllz9QVnT9wBmbSgxeVuleHze2XbX11JS6vY6vQt1O
         H8Jkh8h1PASNTwLKhcCGswPNnbcmfltY87QxiALtMzqj+cIIhpA0Q7XKE0lps0ID/7w3
         A0A2UT4B8JGhLl9WZ2qf9hQpNWEkBmeDGhXPemOnRZo1LTQpfyTErvWe0MbsGp4ABa8g
         lhtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786974947; x=1787579747;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qCQ8QwH+/ilnK3pMvAgG+RA65ORehXDT+fzjCM2bcU4=;
        b=B2zQnhf2x5Lnzee/ai8fZOAcOMmuuVOsuVf21R+KTIqP+pacHz9VJHMpMKl0Z8p3Ck
         B53fJxNqX+iyRWnvaIuEY9D3GVvq9ebeS0/v98xMN8fRZPPThVQ2GWpSgTw1M6N6M+co
         nEd9xezKzYbnQHUv1YJgiKTQK4xYIKWAM+RUksdCQ25U9rFQmFJc2Bdu1Imwj5bMly88
         hehl9FJDrDYkg1z3g2N53Zmf6pOS/G2j5xU7YahJEF/VuVjQEL02xnBspj0sBUcVYAVw
         2e9bvuOg9DgQO/Jg0/CkkNJeyFsYN8B8JexTb+/ggzRQkOAX0MILdxQZ8JgR3NwZT9Bz
         KiOg==
X-Forwarded-Encrypted: i=1; AHgh+RrNAlfAucWd0Yj89b2q5pFQHhdqWLFbS86wWJkH/WDDxjiKN4dy4h9IsBmaS/T3/3LvZvJRsvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVZ72zyBLxLzs4TAjuRXi+bwYSz0cLXFDsehsgB6FTWpPRZciO
	QAo+JemfZ6nEMI68USAp7WyPWMDdEJuwNwKIimOs5uiHr4d/wHMU5f1f28d1FnaY779aLkAx3Np
	6/Jdx1Ry8lKPgJFyK4+TREynZuthNy4/kT1UG9Kz+QyuDSRrvdUnRxD7bwmg=
X-Gm-Gg: AR+sD12hZ15d1SVsW+DglNrXdmSJXgUEr4lvOzunqys0inC9xWz3HzoxyCgVgPkXppD
	RXocTvx1nE7fWtGba9fYqCBQDnJSR2t/QVKweffypUvmSBPfSh06t1cdr9PUSOhhqThapPxbF8R
	bZozgMNLDSUcYemj7CzSJdkWBLY/DuWTkwckVvETLCVrWrtvz/OfY6ZNkGklGx1hdeeLiPeJ/7F
	DDQ6RqYnFSYU57Y0JfhTK6/73e5Nn2T0bivQqiEz1+KdXbWQSpDip9ZLANVVbkjPpWJr2zMBFQ3
	cIN30Ay+SY7Lgro9vn3cBSv0JG1JHycYC1dnWxxojl1vMzjz5+3Fz9IHgrYPs8Dgan0sXtX31i7
	l4AE8OR4j4Kwy7A7qucaoo7Bo
X-Received: by 2002:a05:620a:3183:b0:92b:14bc:7936 with SMTP id af79cd13be357-936d22401efmr1854655585a.1.1786974947205;
        Mon, 17 Aug 2026 06:55:47 -0700 (PDT)
X-Received: by 2002:a05:620a:3183:b0:92b:14bc:7936 with SMTP id af79cd13be357-936d22401efmr1854650285a.1.1786974946658;
        Mon, 17 Aug 2026 06:55:46 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c217fea2cbasm65569166b.19.2026.08.17.06.55.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 06:55:45 -0700 (PDT)
Message-ID: <e3b06684-496c-4efe-9bc4-65d29583cb7a@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 15:55:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] i2c: qcom-geni: update frequency table to fix
 timing parameters
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>,
        linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260812-ipq5424_i2c_scl_updates-v2-0-e09cd39d01d7@oss.qualcomm.com>
 <20260812-ipq5424_i2c_scl_updates-v2-1-e09cd39d01d7@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260812-ipq5424_i2c_scl_updates-v2-1-e09cd39d01d7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=FqI1OWrq c=1 sm=1 tr=0 ts=6a8312e3 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=m8CyFLDg_-xQ2xLGYakA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: 5x4a57r4K6ejsx-Zra_XVj85bwz0vl38
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDEwNiBTYWx0ZWRfX65CxscpL8tX7
 +xMNopTr7vvI92O5Yv2/ZywsO0HvjL4khQhZKRyh3H7QRHPI9giJ5BK1ZvB9/HFrink7EeN2rYM
 XN1jLCjdYgqGxOCldPlyCx3kxZcI0Bh0aWNH8rlq9F9u/QhCktNdJn4JwpZpMhUfAuuzWdyw6Re
 3AjcWYA/wnyE3eJ/qZZTEghzl+X5grunSzpSZ6Qgf6XOMC+wxCsZVxY8131oVaZMIZuT2M4/Dvb
 TKtyuZvBKxZFALu/rjACeDJvqtBZJQEB3dySIHhHYRLi67ku6aASdmR3ZyXJdGjLoYuajSbmHVY
 k3mVbjpHGuM8N6r/57LlM7h7RA+y1bvyPAFGxhY36XtZomDafmPgh37fZv+od2/byQSS3SyNDfh
 SmzI5mZ5x+67KIV9U5N4DnCmLZHbpw6yNv0eNyv/eNLuBmUgBaiUd9rNx6k/2Rv6KUkXG6fXgsY
 oFVNCDECaT3ccp//DjA==
X-Proofpoint-GUID: 5x4a57r4K6ejsx-Zra_XVj85bwz0vl38
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDEwNiBTYWx0ZWRfX0b7UYNx53aNV
 Hdm+FYPPK8V0VFo2B5ecm++2hQ17dA9ZgXhmYi69Xh7/fzuvxCSVunXP11qMqPTdbnMrwGtMER+
 uJVNLFoXJIOoH5u5xIHKN/SQhgb1B80=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170106

On 8/12/26 10:30 AM, Kathiravan Thirumoorthy wrote:
> In IPQ5424, to meet the setup and hold timing requirements in the
> standard mode, update the frequency table with the values recommended by
> HW design team.

Does this have any ipq5424 specifics, or are these just adjusted for
the generic case of srcclk=32mhz?

Konrad
