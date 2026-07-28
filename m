Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B79E1CAA6C
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 03:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785207645; cv=none; b=ItOFPXGaGYI19NM/yMN0Yf4wH82DHPp42SDXiwD2UCtpcIlcoycGwwcPem49ORz+YjSKQ0N+70qeFsMfKmisnNmhWqJBeD7cMT6HZhebKfYb2HCn7FiJJtV4OC0kKvIMlbJ+L5zJSMMkCZ7th/Wf5xHFLf+/juRpTyXozUHiy5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785207645; c=relaxed/simple;
	bh=v9FAnnkgtef7o0Btd91SV824pFr+EW1otrwE9PyqoRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2kK57pBWKj+ffTwME8MFGIEGgVDcPonh6hzNUIsIpJgU8FdJ4pYjO4ZB3VOBuxo2u0zDEkgOwUZcgPB9lHPLDIGcoO4r2louTfnVj4drCLR0jPtGWBfWMiHehF/y9u5tC7U0tt+fqeUODVjMly5rODzLraXyFdWWVHRFKse/Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ESOUZiQ0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Dj+x77D5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ESOUZiQ0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dj+x77D5"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S0kw7T1048223
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 03:00:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=4H2lw0DeUmN1NFymrO44zgqA
	+F31NAH+zaf5Yc5R9Qg=; b=ESOUZiQ0lHAI8b3mqdDgwUwA0QmSo2K/FaMT8B1H
	5eN+PCoqPvH5Yg0Iul+q7OyYjBVlpZoqNTqVg4a3Tg00sYLnPOM8ElJ8WVSDuEe3
	sTmfk4oEXLNbepmZuKcz744sqIBUoKEWux9sqCaqOT/RcAVt+TZOt4Iz9Tunrsuy
	uwnRPtpZuZ1exGJaJYBymXNz25sK8ZKTpPYLvNePhFv5YZ+JIZD1UwMQVxB7XrT7
	nL9GpKtZ6HgrSwiunJkNMORFVqQKlArTkIw3cP0EDon/FeU316nlaQJciQaHLHr8
	7fHA8rLPHu4lJpTu0tBVDvbhRrZepn3tHnRveVox+tLMcw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp3v2mbrd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 03:00:42 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8482b95574dso3540183b3a.1
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 20:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785207641; x=1785812441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4H2lw0DeUmN1NFymrO44zgqA+F31NAH+zaf5Yc5R9Qg=;
        b=Dj+x77D5KjjGY1K6+d8UmXAbxEDpgTGDQePx/BBd9HHUxvIbsU9I6sYzq/WTGGJsj2
         3f58P6ZKccN8eMT3JT2C/W6TJksEg7b2EIrqItztfTerEByp5BAlaSEnYZdc0S53rx6G
         jxMy8FkjeJnX7ouHmJvQMpD2RqZT1XTovN6htk3/wKLODU6v1HD9w8BtfB49O+GDo7HU
         I2LoR8imCMougjkqxo/ykmrDCLe26G9h77Qu0fRx1ktW78S/UzTG5BJDCtjr9f+6e7nJ
         JrdMVKeIBiTieC8TH10aWScowa0KkKDZf6lY+8NsWbzmTa2fpm2OSoOVntNcdY4eXmBt
         UuRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785207641; x=1785812441;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4H2lw0DeUmN1NFymrO44zgqA+F31NAH+zaf5Yc5R9Qg=;
        b=BVdI1HrYpRcj4Qeoo8/Y7qlSFUL0lP8im38qnQCSdUIvbd9c18F5fN+p5zNw9kWa0I
         9uuvwq0dwJP64IHD8UFxeKAgR2Z2F69tgY6YwHbRoC5DUpPp7kxAzccfi0+eKd6SostV
         fC+E9bTEl6bdfdoZX3/aH4Gsid4g8P9/qPh/1/Th10/HkefTOJqy8ot/FiVWCUSBESoJ
         XfadetA3/SW6lAlCxztCu/HnojNaogrlH4v7O5CRUd7NfCVrRuM1zA1GCHCygxQ+4Uyo
         ElE3lXelkmpkYASzjRMxHffjtOj81SOkE54p2/pb0IDAd3Qkf1cT4OVcKvpF3wVtgGEq
         S0wA==
X-Forwarded-Encrypted: i=1; AHgh+Ro4kqOELfcikCFp7OJJPFHQ/7KDDq/QoB3cjwTwuPEaj8aDwUM8rTlgvVQQzM0CU3SK/QCkfAo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxu/6I7P196ONWSV7hTimEKWGytYRBlmmf4vfotBbpUevkDRKB
	a5ggo26A+ODhoHLtV7EA9uPT8oenc+pjZ0DgGr3yCz1C7JKQGuW9IuCTjgJxUS6zv1gC5kqaQHC
	NjMAw3KqF35TIjFekgjY3OSGIvzOWm/q40uMPX9HDlHrBOwtaeqv0jify+8M=
X-Gm-Gg: AR+sD10yDqIDXjzXFYrLRYx0ZtVI4FqkMrWVrC33owwT1DrjGHGtnQdsIsAqFaGPjrr
	/NZrK1MHxuZafyQYclyj4X1UmLx1Gc1Y7JbXXdeevTTCXrPqkR1mqF2fJXGoFpB4ra3cjdKP0jT
	kiglfIqcRU7pUSY8Zooup7ovYxVv2BwaXVxSWD4NJckf/E5dAqoc9Cci1uPTazHnmevL/so2r0V
	y8ywonYzxiKRCkvEwfhygO+LH+OxLzpqE0eS/UsUYuh/T4PqWlX6AGpPhjLlAPV6+0sgHvbtqyE
	3WZn+k0z6pUF4b8T8zMx+J5+NQILSRqyNMpp8PnzUGWIVMyewD+T4lFn0P0TtNcxus9wE8NcwI+
	+zVxe2F79uefRmAeAJPBg7VwQziM7GcHqd02e/oQgCsIsA88emA==
X-Received: by 2002:a05:6a21:487:b0:3c0:9c19:65a0 with SMTP id adf61e73a8af0-3c8ba63bac4mr751844637.72.1785207641108;
        Mon, 27 Jul 2026 20:00:41 -0700 (PDT)
X-Received: by 2002:a05:6a21:487:b0:3c0:9c19:65a0 with SMTP id adf61e73a8af0-3c8ba63bac4mr751782637.72.1785207640434;
        Mon, 27 Jul 2026 20:00:40 -0700 (PDT)
Received: from hu-petche-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc548efesm38935056eec.14.2026.07.27.20.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 20:00:40 -0700 (PDT)
Date: Mon, 27 Jul 2026 20:00:38 -0700
From: Peter Chen <peter.chen@oss.qualcomm.com>
To: pawell@cadence.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@nxp.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: cdnsp: fix wakeup from S3 after controller context
 loss
Message-ID: <amgbVsk6ioQQGzat@hu-petche-lv.qualcomm.com>
References: <20260723-suspend_resume_fix-v1-1-c12a0e8eaffc@cadence.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723-suspend_resume_fix-v1-1-c12a0e8eaffc@cadence.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDAyNSBTYWx0ZWRfX4Z/RfhBYze+x
 eIkl+Wlem8ewAWnGWF7SujIJDuD3zjKRMaZH+lx0wLIr6FVUSUO/rQZaXpptg9crBdz5squxmJh
 KXWQX4Ocln9eFNj/Zgu7/kYqe4fr4Ao=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDAyNSBTYWx0ZWRfXzBUjSKLqxxfW
 1XOPoVVAULsI0jmlma5aKmJULbzD4A5SX3rAx6TM13DT3laxBaSQTlY7I7vZzNGHnmTcGYzs/GT
 CUdBtiUfT/31TK5z+7DRJYaC3dIzBe8SgrFUDPPGaKKzaHJAd0Njmc56S+lo50MX6sTfvrdPz8I
 duiP6wwq82OEMdu1FRWsFA9ILJcyU8d7suUvd3cjLnolle96HkHAqd3cKiOcmgWwieBHWEcOgGM
 iwQ7rs3spmbgAzxL/WRMTHr8yoH9SKmXpNjHG16AqZILG6UJxziy3Ooc7OLYce/P3wjspeRo5Ka
 Lb2boe+weGJGCbdtKdXQKXHonR3TpDmhInBS7SXSjNfV+OpCRzm/iBWesM50O+faQTaZYa83wnn
 a8X/vIchd23UKOGFTesZ4BcyCFCTR3a1jk23D4vUwzG0lg0GDb+rvuXhKyFnb76Fj4RveiVDhHr
 gMrnuZvB+46OQuEMcww==
X-Proofpoint-GUID: NHHoAdQs3DdjWytHRlL55X0BPxuugYUi
X-Authority-Analysis: v=2.4 cv=KJ9qylFo c=1 sm=1 tr=0 ts=6a681b5a cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=Br2UW1UjAAAA:8 a=VwQbUJbxAAAA:8 a=ntf0RiqTf2ERiwE4RmAA:9 a=CjuIK1q_8ugA:10
 a=IoOABgeZipijB_acs4fv:22 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-ORIG-GUID: NHHoAdQs3DdjWytHRlL55X0BPxuugYUi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_07,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280025

On 26-07-23 13:28:27, Pawel Laszczak via B4 Relay wrote:
> From: Pawel Laszczak <pawell@cadence.com>
> 

Hi Pawel,

I have already left nxp six years ago, please change my email
as peter.chen@kernel.org.

> CDNSP controller loses its runtime register programming across S3
> suspend/resume.

It is not always true, it depends on SoC implementation. For some
SoCs (like CIX P1), the controller power still exists when the
system at S3.

> After resume the operational and interrupter registers
> may contain reset values, which prevents the gadget side from recovering
> correctly and breaks wakeup from S3.
> 
> Fix this by reprogramming the controller state required for normal
> operation after resume, including the command ring, DCBAA pointer,
> doorbell base, event ring, ERST base/size and event ring dequeue
> pointer.
> 
> Move the basic controller register programming out of the one-time memory
> initialization path and make it reusable from the resume path. Also
> separate ring allocation from ring initialization so that rings can be
> reinitialized without reallocating DMA memory.
> 
> This fixes S3 resume on systems where the controller register context is
> lost while keeping the existing DMA allocations intact.

With your fix, does device mode wakeup still work, does affect the SoC
like I mentioned CIX P1 which keeps power at S3?

> @@ -1575,9 +1576,13 @@ irqreturn_t cdnsp_thread_irq_handler(int irq, void *data)
>  irqreturn_t cdnsp_irq_handler(int irq, void *priv)
>  {
>  	struct cdnsp_device *pdev = (struct cdnsp_device *)priv;
> +	struct cdns *cdns = dev_get_drvdata(pdev->dev);
>  	u32 irq_pending;
>  	u32 status;
>  
> +	if (cdns->in_lpm)
> +		return IRQ_NONE;
> +

If the interrupt happens before cdns->in_lpm is clear, there will be no one
handles interrupt issue.

-- 

Thanks,
Peter Chen
