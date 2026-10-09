Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B91549363C
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 08:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791533511; cv=none; b=jSSWbX824AiCUS6uWNPAxQXhK3L8k4nIkCb9XriFfRTGGbhb0ZL22wUD1Z8zPC12ZgXnJDwXYRWqPlYTlMPRevxwPpeg/GjIHy/+Wg5dXXccAAj0hj5BXrW4XpV+CeZ5D8b50jtWcrqzOhb8DKH8LXc34iUPwI5iiOpwhlqEs3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791533511; c=relaxed/simple;
	bh=gRbbps69VA7y6AulrLwCFY/nwePzdK2qYrbO3Y+LK9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UrO1O+787NsAhPU7y+UnF6SzyzzG2iyncvl+MHlDgPI48piXpftc8qpP3w1yPCXWU9NZhvWR0nmYKSkpxsOHzM76KzLPkEZOE0OxO42C9IF9Tqk0tdHwJ3g6xewWf8VnhdVY2+1bjanNz3j1rLIBEZlIgZdjENUySkxRD6wkSMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fzcMbtO/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LWTyU4ps; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fzcMbtO/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LWTyU4ps"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6993HnAE251167
	for <stable@vger.kernel.org>; Fri, 9 Oct 2026 08:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	laHJsYnI/7xvkYGI4cOJBcsCLbJtIbGPxkDhu0frTK4=; b=fzcMbtO/4jaXDsL7
	gyiTrLMv+dryBtFCkSLJXLL6xRC3loCmHoBxikesbtcI2n59pEfjAbFFqVlys9cK
	wgzZbkBfOCDuOdR728Q0enWZ9JbdarRUaf/Y5t8zWkQ/1Ad+A2Kw6W73cf/sGLo+
	TH2ZrS7MF7HIwVJAirB8J48huJvqMPKmpX2IIIxaD6Iqfoxi4p1nQSfvtbm+Kb+X
	IEGXn9VvZ6c8KC4cvcFOER6dWWmzUmAHOX7uIaIsBDeu2F2vtH5KcogCsxd0iW4N
	8eJ/PG2jfE6q4ywIf0IenZsF0/s5ls/d09K0zripZ/U5DgTAYz12jurE/vDxZCiq
	aUgBvw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fmqtqmc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 09 Oct 2026 08:11:45 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93caf6c528aso1012999885a.0
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 01:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791533505; x=1792138305; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=laHJsYnI/7xvkYGI4cOJBcsCLbJtIbGPxkDhu0frTK4=;
        b=LWTyU4ps7R1nnh3W2ZLte7OPxr0Cn9kCJoGYhRJAsbJcr2Z+QbXNIdCATJVpPl9hCx
         cN5SCfK/JReW/5Ruw46AYztuTqKZisaSVDyomfgN02mQAm9pZDwqlJt4BjMMdJTpy9Cx
         Pmv8YtSrWyjoWUq190x4dUxmyaymhAtOFbChD1ZG2hxtV8pTq6VKK7YX7V7Ds8DOwv7G
         02H6AMnAqQyg5BeDf7iv3fQ0o3sdZXqAr8U/8iAJ5mdCdnRgwnDU5h2i59tX9/4Z4/ij
         NKrfN7nd6mEMTiAUlbzVB2a/gCEpvN06w+lMGaYy0+YBmOllfCHQMMY6mkvOggezpeek
         Nang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791533505; x=1792138305;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=laHJsYnI/7xvkYGI4cOJBcsCLbJtIbGPxkDhu0frTK4=;
        b=xd+3Uq6fF0hncTZb9TE2v+n+M39pHke7IWyS4cBF2T4woYvN96FQCJg0sKaulwOl2J
         kad2uDd9nqywgafIPFfzEpzp1vZ7xar8MF2ur3+UFzYcRHVZdA+Vthv8bnhkshu4PqQ2
         zePOeLXjnSIFuXsQp37lZBxJAvO7AdjbIwEOnFfos8lbaeOZVihwio0Xf/W1p5rftpnG
         WPV5GmcfacVDO/0prCPQwXGRbpj7nHANedEZ5aoug2XZKA1Ql/FjTArA2KPBmxxP1MRF
         M7mxL8iqIG4qyEZmhWVfPi4RNi5trDJj+cUhZWXSbDCtFhBLBltL/hWnOo2E36mvjivM
         2TTA==
X-Forwarded-Encrypted: i=1; AKwUvBwqpjWGOGrH7VOUKtquwQKJZnE4bKD1TOadQlcuS8g48Nqig9FxXcGImSyo94STQ3VJmOqVMyY=@vger.kernel.org
X-Gm-Message-State: AFuF++kqVbV9NmAjBoMraEmLZ3kjX6Kmz6HvagNBP02U0m3FValFrRoH
	U5plljk+YBZpFKVUxSMJ4POLQnTOxlH6SEo744CYiTUd6aRIsbEuhWm2QwWjTvym3zj/DBxUe8s
	He9MxvpwEUk1OsIazoLVxahNqp+FWa4btH1iLzVC6EB+4ZoipGJk7QUQ1HKQ=
X-Gm-Gg: AYBFou1hHm/3zuU4q9b+t/yjs5G9uNd7KNuKKX1JHh+tCmXpq2L1Vx44sQq3Fbbu4D0
	Gyq5PiOSIefjzK/byR4l2KpkkcIDIkwNSFEn9DDNbG0mak2usOWYKz1c5dWZcT0vvjK2u/SzEaC
	TPAYv/mFYD7kB8AWCZwhvCqOEqQNGX8U7Ak3nG5b7jA8JEFIOJXEp0HE+Vm1XEdNFhMWxiINul2
	b+kesc2jwvlaP7FmHkzoICK6wtd6kq7gb/ZVJw1aRjsgqoJpcD+Lcr8/5XikF0fVganjPU/AFzQ
	V7U1xH5WRtIt+HU+TR69x2j8N5dqMllDC7VoUqW5FMh26C/8cB/Um5TacuAlgXyQVug0WDKYs/V
	kawoodjpA+WY7207MF+tl6Cs6SSI=
X-Received: by 2002:a05:620a:270d:b0:93e:976b:5c44 with SMTP id af79cd13be357-93ebd2960d8mr145641085a.65.1791533505212;
        Fri, 09 Oct 2026 01:11:45 -0700 (PDT)
X-Received: by 2002:a05:620a:270d:b0:93e:976b:5c44 with SMTP id af79cd13be357-93ebd2960d8mr145636485a.65.1791533504545;
        Fri, 09 Oct 2026 01:11:44 -0700 (PDT)
Received: from hackbox.tail37bb1b.ts.net ([188.27.161.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18be97d1esm65404655e9.8.2026.10.09.01.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 01:11:43 -0700 (PDT)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Frank.Li@nxp.com, Wentao Liang <vulab@iscas.ac.cn>
Cc: abelvesa@kernel.org, aisheng.dong@nxp.com, bmasney@redhat.com,
        festevam@gmail.com, imx@lists.linux.dev, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        peng.fan@nxp.com, s.hauer@pengutronix.de, sboyd@kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] clk: imx: Fix clock reference leak in imx_get_clk_hw_by_name()
Date: Fri,  9 Oct 2026 11:11:34 +0300
Message-ID: <179153345647.1914323.1489876411002078599.b4-ty@b4>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260915055515.1730145-1-vulab@iscas.ac.cn>
References: <20260915055515.1730145-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAzMiBTYWx0ZWRfXwH59U3fbL1Z+
 /0xAvp7r7gmPdwtK1laPO+eS2Ukbyse3Tzgzp9fL+LDCXkue8IAOXQEsuZBWGCiEgc3Rt56me21
 kpx+GRqopEAgbCa/ArL04Om7W9sZCQQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAzMiBTYWx0ZWRfX7AiJ/fotIMAV
 z1Di/Dtjia7p0pD6F9w9USxS1hTovlZmMStBE/H/EZCAb3rUm5XMT1wBNe1oNzp/qVVFgCc16s9
 P0TSm8g8yjMeLi9wlRgQnBXFwRA3BiKnC/VLzlT0IJPp/yHwiMUhh67fy9QO+W4frX+kKt8rS2h
 SGms9c6NW2fpZlniWfIGIjXFULDMFTOsUkDbimzJJ9/PkW2A5QHN9BlazuieZaKujrLHocv5o+H
 +1sJlzj/mV94mmQbiML5JBpI0ywxNteLKYWbwT1i6GJRNKHGXiYeTFqCWWTwJCqp5kfZAY2qKho
 ypnTAwiskaQ8dhbV1e/1LzM5hLj6wcfomMGfyMXVyinvAkmG7UdLhKBoMwYWqfRodpqiQC1OASy
 BHmmGOe5D9eNinGZ3A8CWy8mzMyXYiMqwTLK61jmYJiG1Ys02znkJaiJBL96shyamCpMbr0MK1l
 l0QjoRfrDRucjzcwqKQ==
X-Proofpoint-GUID: UPm4kMhsdWjc6Jdw8oQJ9ZTTxQXqcy3_
X-Proofpoint-ORIG-GUID: UPm4kMhsdWjc6Jdw8oQJ9ZTTxQXqcy3_
X-Authority-Analysis: v=2.4 cv=IqCL47/g c=1 sm=1 tr=0 ts=6ac8a1c1 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=EiYrS7xXfcF7w+nkr41hpQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=DNK6b7R2SRMYshW6mIMA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_02,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090032


On Tue, 15 Sep 2026 05:55:15 +0000, Wentao Liang wrote:
> imx_get_clk_hw_by_name() obtains a consumer clock with
> of_clk_get_by_name(), extracts the hardware pointer with __clk_get_hw()
> and returns it without ever calling clk_put(), leaking the consumer
> reference on both return paths.
> 
> Extract the hardware pointer first and drop the clock reference with
> clk_put() before returning.
> 
> [...]

Applied, thanks!

[1/1] clk: imx: Fix clock reference leak in imx_get_clk_hw_by_name()
      commit: 8e177ca735761a1f03e1dedffd7ab00d6d0540ae

Best regards,
-- 
Abel Vesa <abel.vesa@oss.qualcomm.com>
