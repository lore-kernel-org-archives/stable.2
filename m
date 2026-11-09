Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794217179;
	b=Q0jVZ8J725lI2gbvWd9ANeslqQXwIetkEav7o5St2dxkyYEWvYycAZf3iPwF7wZJ4M2f
	 QWKtPd+CQuROTcLwxwtMKKg+Raw+rSNYyqrRe6S3uD5elAAYqGspuOj3NYzXGBhmldwuf
	 gsX49q2WuyNJUrpUBij+uSBf8N/DCyyruwYrGzmWg1xgfcuwSXl4gjOuZLsHy7jCLu7cl
	 0YBLcJp+c4U1VPBeRgdjLFCxtJ0NHC4DVg+KlVWYyw7ek/t0yJo7IdTGl4M9KpJWpNHBs
	 MS69/BUJ7cayQaAZJp6Q8B4Yfgy8ofiPOsI8nbEuiP9wkBEQf7XrqGToaFvaZ6YtgsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794217179;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=k/MryLsTIN5kVKTH3Pbnv1AmufsI/5+jgtemRo4uues=;
	b=y3DLW6fBsUBT51iXntat6nrpVyhEMpm3bLzb9XY6n3rSBFC8rvF/t4uKMEKO7pNkVdUe
	 /MUwbwdqFotf5E/FLtFTmjmn1s0cn389QcMeJpcFXOpwuPKrdXpT90n/SPCQ+oueqnEbs
	 05unhtSOmWnALsP0Va0U0HgJOVuc7+3VJ9UpM40lfMKRW0Ypa438xpqrL3GR3MT4zoS0v
	 VaZZUBBcJNah/XFjpFy3jb3s8dLIkOkZxv7EbE+uiDTRuPZORcuop5nvXv10wG4esuM0c
	 6xV45JJEt4jIhvxSupwqB6Su8cQsGVAGwhMwpwL++Jq2aFZhTvNozzZfBrOjsNzUNGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=acN6b9m9;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SbUGFBXn;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAD2606A322
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 09:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAAD2606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=acN6b9m9;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SbUGFBXn
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A96A6kd3298532
	for <stable@vger.kernel.org>; Mon, 9 Nov 2026 09:39:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k/MryLsTIN5kVKTH3Pbnv1AmufsI/5+jgtemRo4uues=; b=acN6b9m9Ya7+MPom
	5ezGwy6+9ze2aJrO5B8mZ1gvoToC6REdvTsXHNQXQxsCQAaZVQyd6YRQy16NkrE0
	mjRx4KysVzyNtt4BanXHR8lhg6fTzUGFkxfJtDnWmcYTjoMKCihjKA88sQjy942z
	ZA2onwyIym/K8pWDPT26nd2hFgdVgsBm3n1oTRuyo69zpdwPriyt5v5U9B2NG6qz
	ZzKafRFG1gBC9AgSmZABpR9WZ9sIeqJbNLi2M9ydJk4E2EEfmIT1/mxLy7CXS6EG
	61fm838ukAIgtDHePiWh8aWKjibPzat5upPx6VnRnFCEFjHVkaYeE2VzvHNxsTSA
	eVQqQQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsuagwsk3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 09 Nov 2026 09:39:37 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-91ea5866643so13740446d6.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 01:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794217177; x=1794821977; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k/MryLsTIN5kVKTH3Pbnv1AmufsI/5+jgtemRo4uues=;
        b=SbUGFBXnYu4eL2rXFkAUf6rM0Ta8YMP5cAsdQAK/TxTlOsWWNlxGIPQzHGwrynr35G
         y6J+ly1neMyJXY7sH7fNztAHJyf4chJzf2avsnXO70B2lcJS7vh0rFjWAI9cw34WeGxg
         6PNkt5r4WTQ552qdHs+wIrv3IOmeMJVXgQcaU8PwFJ114vQ/3SOcPHoTanUW3PIkBUrm
         g2wAUcl4QtYD2R0AboE2V2lDIJtvo3X3za9BSvjgthmUEIqIemKrSqPviSxDDpt1CPOr
         AjuBUsUJaIoN6ZcI1cj1sFGDYOwz/A99QaTKIbrtqYI1qE1QHzIPff4xuIlH2EcARw8/
         kMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794217177; x=1794821977;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k/MryLsTIN5kVKTH3Pbnv1AmufsI/5+jgtemRo4uues=;
        b=bTZOTIgI95+DAs8zyBUqRN90jNlorDoMspfg7JoTXulRhe/3xO6RO3iad4FgbCmN/7
         rpM6RYe583kBJ+5Zhs5HS9+GS85gdzuTErJTNCGkEKyDt8qRIbhqU9RPVovR8DNWYw5/
         PW7Ij4mZEWoLCsXmx7ogXBmHgHkG/8mk3k5sk9FA2fT6ohoz7b3WsGPlF7mL2HshcfBp
         fcrHc8FZgyQe9HP7p53V4EyYDbo8PslUo7OpwUJDuQU897tHM5H7TfQXi65gSMAFnExF
         vgGCibj+fqQj+WBNEwRucRUMYoeTV1mbdUb+d65k+EV5EbgFEs2Ea8qJnQrxx/aUcVaS
         U12Q==
X-Forwarded-Encrypted: i=1; AL+hErE699yq5fYGGSlRmPEChmGf0VXrn8FJqFlAM3dtzHIh31/yU1v7rgDWWADqJuGy0YwYaQcFaug=@vger.kernel.org
X-Gm-Message-State: APuU4Z9rPqmepQQLee3eskN8WnfuO6y3CrtKrdAPc8bwdFQq6IUp9ayB
	dCGUS7nQcjdkFTkl0hiA9DW0CMfFVayCtKL288eLs0p3CGFzHy3c27ynYUcxv+9N/ogwhpob2F9
	xUaOQk7orhEuhmZyGe7ComMSpyXjgoo5xsVD/v+Bu5DjSTZ847mC0VYrJSzA=
X-Gm-Gg: AYBFou3Bhmpl+mVeIFytLR4Op1YFOA06Luija+BSUK41OCJBbJ5qIr+5Bk6d4vbhh3g
	xQmiH+FmcCwOpBI/OQSIrCMMO6jW+HS7a7zEVki8Nf+rg1Ilv8qY9mUlruLybpqMYc+DM7eBT4R
	aMWpVr19mYQpQdsNNfa1sUBDxnACqO5l5Y2pYwZ4dMDKp8eW9cjljg1e7f6q7mCR/tEiOTvZIMq
	iuKFjdaAmbuG+18AzMCl5nRnoSpX+8pH1ZTbDaC2gLpXzqX0gQwM7JPW897Lk0ytKC8sr2U3hPQ
	u111sU8b//U7PxzI72f3z/z65mxFrTDeN/8cRKmtwk9xtr1eCH7VhHjPugbstwaLjFhaqMXFAMM
	XPEvmRzcxkjzkeLNkhYkslDM4X0SvfKV8r4yL2L58jAtiKbkFyj6PsxKRaUtLLa0XeBL6fob/F/
	OGXBB7bq3FcuqTEx3s4zw5nRTYXDRcORaBnxpij4GkDmizLhy2bqeWATsiW0dyRA==
X-Received: by 2002:a05:620a:711a:b0:93e:623d:99ec with SMTP id af79cd13be357-947841e3a3bmr551108885a.13.1794217176924;
        Mon, 09 Nov 2026 01:39:36 -0800 (PST)
X-Received: by 2002:a05:620a:711a:b0:93e:623d:99ec with SMTP id af79cd13be357-947841e3a3bmr551106785a.13.1794217176494;
        Mon, 09 Nov 2026 01:39:36 -0800 (PST)
Received: from brgl-qcom.home (2a01cb1d00dc7e0089167b9b97a26c96.ipv6.abo.wanadoo.fr. [2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b76cb75913sm164965255e9.0.2026.11.09.01.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 01:39:35 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] pinctrl: qcom: fix a use-after-free bug in system shutdown path
Date: Mon,  9 Nov 2026 10:39:33 +0100
Message-ID: <179421717024.24538.4724609411487120777.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261105-pinctrl-qcom-uaf-v1-1-c9cbc0a93161@oss.qualcomm.com>
References: <20261105-pinctrl-qcom-uaf-v1-1-c9cbc0a93161@oss.qualcomm.com>
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
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAzOCBTYWx0ZWRfX7Ko0VGmKLOiV
 xdKF//+8jqFVHyWv4H1YlG9LLvQuF/ktlBoIXUgOlY0brQFwjBdXf2/hKVHH50yZkMJ1AcS9XUd
 +EgW8mf2As/DL1Mh0z05yVhEAheoCp3dq22VwlIsqTfsbdnlEkp0ycJq+UXwXjXm7nQin/DP4D4
 1VdmTWczsB+W8BmWY41M+PdoGDOwnkPoTf8agee6SBZxARGG1PMGaMfgwh/3t7UqE+KASrbO1Ym
 CQQA5D60eVQCzRLbHRio5pfQUok4L4pdV7wuv8oppNGmEkCwiqmUIrjTe0RtZHRiwMH3EaHTIqB
 cc47xq7vAOy8IKhOpmUZg3hEcRFOTX8l2n4DLnithPzfGEIrNA78LIIuKAlnBYTNdeNMCoKysry
 MbpgHCmYxRsKvaqik5tWB8WnhVPAFlY1XOLeKUiejqUpnFMmr+S86qaEpCeyripSuIS0DYe4smS
 OiP5/TyrFM8gFRW9mFg==
X-Proofpoint-ORIG-GUID: fbanneoD1EJ8-Dpr72z-8h3zgyUyHI0R
X-Proofpoint-GUID: fbanneoD1EJ8-Dpr72z-8h3zgyUyHI0R
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAzOCBTYWx0ZWRfX1nxCsrB2OlAm
 +FR6sASBtoscGYCwlzXmuU6t4T/StGk1IOpEPKBwhdNVXlmXhbyZ4Ei6hrlSV0d9YgDvHlFsaW9
 v6TJp/VDy9KXHXExjm0QTeznXHrtHew=
X-Authority-Analysis: v=2.4 cv=V8LoQuni c=1 sm=1 tr=0 ts=6af194d9 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=L5XZeMja_UA31ktuEWAA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090038


On Thu, 05 Nov 2026 17:09:40 +0100, Bartosz Golaszewski wrote:
> msm_pinctrl_probe() allocates the pctrl structure via devm_kzalloc() and
> unconditionally populates the global variables poweroff_pctrl and
> pm_power_off.
> 
> If msm_pinctrl_probe() subsequently fails, devres resources - including
> the memory allocated for pctrl - are automatically freed. However, the
> global pointers are never cleared, resulting in a use-after-free during
> kernel_power_off().
> 
> [...]

Applied, thanks!

[1/1] pinctrl: qcom: fix a use-after-free bug in system shutdown path
      https://git.kernel.org/brgl/c/6c940958950e5df52831fb8c78a045d426b09f1b

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
