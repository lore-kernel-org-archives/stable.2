Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794013688;
	b=jlA/GMOBfd50iWaF+xWu8MwyHaEQNZfvEYkQAqNZCTc1LpKK9b6i9fN+t2r2fNj8S33i
	 tjA0s3HqvBHpeWbO3s55INZPBFgcrnby3NuUV0jjugBUuJaRJDLGgw7N4jsNNAX4AoFZQ
	 d/N+EfnFOe8ja9Qen9kfhDaX2Qh1vsMCpuhzAPGS7Fyc1elTAVwswg6XGpOfYbBJOqGMC
	 H0neN7iM3VLPX3/UQPGkD5mtATMfVKMu0W3yk/WUR5E+S41hqWXqTy15AxR9DVHFqYa/U
	 DrkYLCfljUFntz8AM9e/Uf9lDWMDFJxAY1HCyCsgfHrubrcrbMYI1WA7hEdcUNwBt8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794013688;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=XqszqiOkBMdk1vvS7oxfstl8dAzvdx7vbMieJ9TUstw=;
	b=UBRhD9pN574ZgQs8euVrWPIUyFv/jt+CfYheSxVeW4SBroCzA28qGMCqg5J5kjz1KXsL
	 tBbdHCw5d/72NZZjf2ES+4ff/Agi13bSXvwOeYyJrFqlb45AuebXkJD/GrwUHNTuku8iK
	 LF7SDZGY19T79GO+9cQ3Ct1MwSlLmbxPFWsnlnwfe5yi6/Y7fBcVEdAsWrKRSMbiX8osw
	 1qlHW1v8vmiOswx+ILDo2ddZVgdYKR9zxPNvGaeIX9Mv2BLeSsuyOlPCYZw22i2HDSJVa
	 FlGPQ7uMzOTfNWomTGkTVLohIDUrqkLUmagc5N/Q5OkIPiIDTGYMA5GH8ADTqo0qgqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nzvsnKf4;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=H69D9yvc;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A66606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 01:08:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27A66606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nzvsnKf4;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=H69D9yvc
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6Mo1up1063974
	for <stable@vger.kernel.org>; Sat, 7 Nov 2026 01:08:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=XqszqiOkBMd
	k1vvS7oxfstl8dAzvdx7vbMieJ9TUstw=; b=nzvsnKf4vSqy5I3sIwru73tIh/C
	PkLvqXCjrNMuZRvybGPsDiFnaL+MLmf/w/+fqiny32jbJ0n+3ffI7He3VoZE1nIm
	29PLZ0FYkhyN17eFrL9/yCjtsSl1XGWQdS1FWC3kaG3uDbeRwk3oZgguz4rgdSkJ
	Qvfe8QRetKM0dosQXmVFkRuvs57K7L2i7k2bt1BwfJ4PGYOawDLko4IHgVa1HI6z
	Q3xLqlTIuzyFu6k6tJ9Br4f5AVKQ6qdLWdDzMN/dKJvGVOlzHO+GyUZYXBNIS0HA
	xls7WtflYKX4odjenNt74HqjWWYx1cT9wBrRzh/Ii2re4deua6tzZoFO8rg==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com [74.125.224.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsmyv0ykj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 07 Nov 2026 01:08:07 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-67c2a9fc7f5so262358d50.2
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 17:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794013686; x=1794618486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XqszqiOkBMdk1vvS7oxfstl8dAzvdx7vbMieJ9TUstw=;
        b=H69D9yvc7F435FJmPIi2NwpLKPr+qSEO8rDym/CA0uhzlay0uuYxDQhyay6F1nq+hc
         rEgl0DMDaV8IbmVgJe1GlqUBE1kIYML75u5f+n8q1x2qTByE8vNEY8LS1Lwurtee8L1n
         wZpnFnJB6QCJuKMPhuy6PIttocbM2EGZhvZ95r+xwgfc3efceDJrykgjO+QYxS79C/3o
         NYThuemJb4bU3PorRBZLvs53qtNXxjaaLYFe6kQYnTa3dtyskZ86nfbovA0vuGJEcWtG
         7TT47vD7C0hmOE6ZPipuRDZrDxsujvkHBHGQ9bYq+JyrRT4r7MjF9yxuodKMNtnVJQ7T
         ZEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794013686; x=1794618486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XqszqiOkBMdk1vvS7oxfstl8dAzvdx7vbMieJ9TUstw=;
        b=pKi0HDE9xvNNlKX4uDuccA9Nio08fyhZQgyFb/i1kE8qJaDILWDwj9IgNNtq570Xp6
         2UycYsAdVvKgU5NVBLYs2DnCHzrVS3keNf+eALXgTLliL5IFzXupdT+wYDfeJvhl/Ofu
         CnJL2i9CHlt58lcvKrPujxlXiumbR9tpEAvD//dXUzhmilmvXY5ggc7xcsyV12Daa0fP
         WlXRSaP5BUeokcsl89WxM5zICzeE/IgVfL6g41Thp9llo45HpgUrNyBf7HUXXGwg1GqB
         3YJUXiZ8mD66WHRgf6W07VSjKAAzJBda1H5XzScYNrfKP7B4+M+1Bo/qf47JlTZBM+bq
         qpsQ==
X-Forwarded-Encrypted: i=1; AL+hErGSNGbI8DMcyCOu7eYmx+V89YPCzhrN4KMYN504fSDcFNjya+fww9y2bQfGYRmGF0DU/0O9sho=@vger.kernel.org
X-Gm-Message-State: APuU4Z+qH5P1/FPd9HHcxrYiSH3UED4HNm5JFw89bveGaFqVGpN2o89+
	t/iooel80edz8YMMMY3I75yi21uKbpaYPE4/HK30hTbttCn4tFmHVFnz0yc6GQuBP+O9JPzcBhv
	e/Ks1zumyKZNTNFc4CGCw6j/oD12ui3x6PsBjhIpcCKQQxSCfD7/7F+EFJYM=
X-Gm-Gg: AYBFou3f5GRym75mAitLijc189p5TVF7UlsPJswyyNixC+gQBEg2pA9VJs/uINFHoUM
	IlhWrnsow+8YWaFI/IjQWhcjhvUCimUjIskxUt7ZLCKZC475k47DVF2PhozkloewtZZjT3gYDLH
	5CoRvQNrEgSlr/yL897y+PIKkehUEcI3B83AEZHEiyNL8NtORmlRtCvTWCC6bJz7Yr3dSD2zF5B
	Oi5oVs79hTne8z+plT2bK3g5sNiaTGldIGG20ch6vlSj7MfgweTbBj7OtKzX4zSdsBpz5xSuqpk
	Ek5Vs+Z31nokGhBjZ9xnqMi3e/lrQQBh0J4Cne74Dn3gmu1hMdhDTG5zDvTld+mDi/mRXqRDR3w
	xAk1L0GG9hQdMnTFkVtTBQhBXKoDJtwmH3g9L7J1PgIvIff3m8jyop/ZKJlrLIk1VlogaRiuj52
	58W3lpyZ1bxgXG6Q6LJ6pPsNfiWMu3sOrgLQ==
X-Received: by 2002:a05:690e:4814:b0:674:d78:4bd with SMTP id 956f58d0204a3-67c1407f86emr1633708d50.5.1794013686309;
        Fri, 06 Nov 2026 17:08:06 -0800 (PST)
X-Received: by 2002:a05:690e:4814:b0:674:d78:4bd with SMTP id 956f58d0204a3-67c1407f86emr1633700d50.5.1794013685859;
        Fri, 06 Nov 2026 17:08:05 -0800 (PST)
Received: from x2e.lan (108-208-224-205.lightspeed.gnbonc.sbcglobal.net. [108.208.224.205])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c134f0b5csm3091934d50.7.2026.11.06.17.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 17:08:05 -0800 (PST)
From: Tyler Baker <tyler.baker@oss.qualcomm.com>
To: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
        Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Escande <thierry.escande@linaro.org>,
        Bharath Kumar <bkumar@qti.qualcomm.com>,
        Chenna Kesava Raju <chennak@qti.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/2] fastrpc: fix probe-time races between rpmsg and userspace
Date: Fri,  6 Nov 2026 20:07:59 -0500
Message-ID: <20261107010801.3451213-1-tyler.baker@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022-fastrpc-probe-fixes-v2-0-a6b3f6f62571@oss.qualcomm.com>
References: <20261022-fastrpc-probe-fixes-v2-0-a6b3f6f62571@oss.qualcomm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: gMvX9u2WzNvWC0jliZ5A-5uIJxPD6Jwq
X-Authority-Analysis: v=2.4 cv=IdYSymqa c=1 sm=1 tr=0 ts=6aee79f7 cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=PFxtTy0squD/fJwW5Be2sw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=fP8dIGKjERIvVM-sKqAA:9 a=nd2WpGr1bMy9NW-iytEl:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA3MDAwNCBTYWx0ZWRfX42QWE134f69e
 +JqCHjIXUuXIhM6aBqBqK02NrBc0BJSomc+aKTYqcjbbqmJFL39eQR2pS2PkbNylaVZHEy8w3A4
 UavnXvSpVS3fllR3O1rXzRg3vrE0Xno=
X-Proofpoint-GUID: gMvX9u2WzNvWC0jliZ5A-5uIJxPD6Jwq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA3MDAwNCBTYWx0ZWRfX71krp2gRXXSz
 j3OMv77eRsswgtbfZ72VvH6Zwk+t/CesI5Q6R0hoXyNkHmK+lvJaNp/VpsvAyUR1tPzIX5eu1OE
 FS+9PE0333g4/HByRbBreE+/VGflT7AYv7K8fV9lDwUD3zCdrWgJblhrRJzEEsv+eFslppc6pHV
 aet7nT2VXPACeOtC0zKO23j8jmG09huc1Q/QOQJewt2JJbilwba5jQaj6xNoFSpzBYMiFn2Vorl
 UetHNsS00zjsRTulMlTiqfEmfP9GPmiPsUuUuKqFw1gEzLNcL3mEPEjwsDputI5neLynb5Nq2sN
 thJEcYqRsTukisV5R8iUZrpPy6abS8HBYN3UycRlfSp0HTu8Sa1f9tBGcJs7mClBn9EnBh0W1MO
 HaNg4GuUo1lDs4/rBlo5SE4eOjthGkPc7zi6oXmQACbgwhdWWM3UnsrxZmCoz+EP0idv5VJLEhz
 gh6RRpA/a7S9wJFpvkg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611070004

Tested-by: Tyler Baker <tyler.baker@oss.qualcomm.com> # Eliza EVK, EL2
