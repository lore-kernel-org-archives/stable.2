Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792500432;
	b=tcT/aEXS+bSx0ypRYFDdJtlkCv8SYWQa9piWeD3l68g92PVCLZ+Yd2YcMY/MW7f4fS5s
	 jOzVdq8CMJ7S28cxukeYcJdNJSNHSd3A7zSF5MgP2oOcSZVr9wMNgeXgiJ6Y1KIahgSeB
	 8HQcJ5Irm5/dV5srJzAbHoT7oxuKqG41zTCgqmeqkHx5iCOqu0JEkGfx/Ai+/lzQpk2ZP
	 qGqaQctFfl/GjYFALw7ZRopWa1lgXYn9oqxEUjVdCW7TUsrE6CbwM52lplnJZmoVaZ9SF
	 j/1Hnp64XOVzJiJXNsp03eSHvz2RQpmgt1z76M4fCOShkks1ZHDNEDfqWXSDXI8HrYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500432;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=C/HunTessReFhmQLSotB/lpU2t4TZwXk7X6wvQ6Dwts=;
	b=L0z01XVkbWQlinxjk9TWHN9CSUke3D1nZEsr1zsUgWhG0yBaIZckgIFq4DN5r5Lq5QgR
	 o75BgwY4fkmkwfFxwMIZGYV0l2AEDaHqJdSfkA3aFH0nYngy/scrFl462ac+uKWSF0dny
	 39cOYUAhj7FhhDYw2uF1EFtByK/AiX45afGN/Ehwml8UuklmVTapIIFBIaNVf/ujAk7zi
	 jEKE0YRguQqpO8wMilBU3DRBgp3IeHCPV2Eldc30Xk5eEZfehEowBRQJlVBZHnS4libgG
	 xn8Qm2enOyGE3ypkrmjj5uFzp15YsEz5iVWGgzqSahpAur2dNt9/4LNHTD6gM2i+44w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VyokrXee;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f7xDjVWt;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45237606A331
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 12:47:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45237606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VyokrXee;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f7xDjVWt
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KAxKvH1145611
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 12:47:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=C/HunTessReFhmQLSotB/l
	pU2t4TZwXk7X6wvQ6Dwts=; b=VyokrXeehHHkJdVm5FZVHFj3XFrfyvK5xifQM7
	JzsJlmIKeFFsO6Sajz2Ku79F3/A4XoUlmtIzCUbpD6azwu8881hYkiV1irj5hcTu
	DgavnPi6YCd68lbZKb/hWvpTrhk4/ODoG9JltqvwEJQFDSX0Nphm1RF+JhMRColt
	kSuDBlfPHON2Jiu2OPjFLAnpKGJLNEFB3jG6xwj9KH6OnAAR4z9YjOWog8U8127h
	UcB90Kv6goGBOuVcUx2jXOSDORKHo/eoM+3RdcmGZ4KPkY3LRwpHBdjkV5N85dXH
	H1S64d4l95oUbGZzfQ9xEhPloC1ZZkJXBkEyYYs/nrzLP9qg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5qafm8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 12:47:11 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f37c94ceeso122579185a.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 05:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792500430; x=1793105230; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=C/HunTessReFhmQLSotB/lpU2t4TZwXk7X6wvQ6Dwts=;
        b=f7xDjVWtb4UEFkaCapyiwwlnjQIakLuwJjFFzYVkRThAXvGHQXzhA9yAz6UM6tsfnR
         mQgKgiBy/yVUD9u7AJ4Bvrb6eoSnowWbK0lUBat4ccuWul0NHoJn1G0Rc2jE+oiPQxaq
         MvTO+QJH1Cis5RoyGKKxpGH0h6c/2iJxN6wMTmdD8nIBtNvXnAO9oCVIUWSUkSmDGaof
         A8vAdgU4F6O8KB36pQNtDdHYmztIfEyjNZ82UYKWjnPzvWC8yOfmKPCAadbTmi1DOAcs
         OyHWyg2rATmf8vN8/cghdmsKWHLb2LCdRTf9x6ccxFfE2O/3WfItcqMfgSoIFc8WtGnq
         NzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792500430; x=1793105230;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C/HunTessReFhmQLSotB/lpU2t4TZwXk7X6wvQ6Dwts=;
        b=bkEVSHOSu/rG5L0zOEvdZVXw1MU7G/NUAKNLCNLlgu+MQfq2pyDiNTBHFUDXt/hqft
         fC8clasIzuWas38J/hmt+3qjQGxj3tHE+K17bOX6N9OWdqCTrEVpnN+bGmjKjz/XVYTk
         KgiflSlOWvJezV9xLd2MkI1tVBDChlEOjE+zq098Kp3N/nKIDiqtoZqlzq9FmQtg8kf2
         R2Mn1oBEbE2FlQ5jW6CFEwfDKKIeZrw0ABXg6BXPpSvBHGdDrMWkDb2K0dP/K4yHFw/S
         xpIJqOUx0c7Gz47Da2qvMGgfKPO228f/GsF7c+YfyDqSDP5MU2V9Np9pX6aKGHOC2y9Y
         XwwA==
X-Forwarded-Encrypted: i=1; AKwUvByM1gUYcYDzKyCldYfCYlSoi5WMAy1Ed2k0lyJHSJv+IzjIaZt3OVDYqc/rODBO6nkHA8tfOKU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIp57viMyQhYK046BVGKqS5cEK5ZxxtN20hhjEcpGrTRVf6MxYC
	T38rgGOFE3oeQNfA1Ps/Had7MKgsmQflpJapskqw1BOZCNoT/8p6mHfStk2GvKwqPefmQ5mOCl8
	tZu5EYJw39LVDqQAa7Ym8x6QxMJ4VONDIFXkPxw3kgL3KCFLXCl0TCqqJhM8=
X-Gm-Gg: AYBFou0US7Rq5+TH00Tft95mHLgAfqNwaFyGKENs5xTKVnPcch1R3hvt1qjA6f/edOg
	7avBI4MjDYZN0DKJjRJJ3xCFhopg8RzktRUVhUp7JJzr434auiMmWgMP6sLDNtNVNHqdoLPHBog
	0M6Ddpt26dh7Q9xTXlDvrDQIEcQxXzECN2CQpGyUBsG1dOMa4S4E7w9x5R169cZ7Mdmdqp4ckmj
	SpXdBqQAw3X4cszYpaexd8D0x9U9DXGAIhVmtdZVvwuIzP6ZxS5ZfcfxGxsUe+codPqYP4wYPuT
	LXrhSiS5hAOFuIeN+LLkCan6cRtAlhF3I/0ikOv+TW9blKUlHcWdet8M1DC+F2H6DNmJe9diG4Q
	AcVO1CYMH1HMqqmSUM1e+4c1WFhsq
X-Received: by 2002:a05:620a:649b:b0:939:5d22:d1f0 with SMTP id af79cd13be357-93f4c195bc6mr282061185a.2.1792500430317;
        Tue, 20 Oct 2026 05:47:10 -0700 (PDT)
X-Received: by 2002:a05:620a:649b:b0:939:5d22:d1f0 with SMTP id af79cd13be357-93f4c195bc6mr282057685a.2.1792500429834;
        Tue, 20 Oct 2026 05:47:09 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d82456asm6544253f8f.42.2026.10.20.05.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 05:47:08 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH v12 0/3] crypto - qce: fix self-test issues in aead
Date: Tue, 20 Oct 2026 14:47:00 +0200
Message-Id: <20261020-qce-fixes-aead-v12-0-77a2e09abd0c@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAMRi12oC/3WNwQrCMBBEf6Xs2S3ZSCr15H9IDyHd2oBtbFaLU
 vLvrr17GZh5zMwGwjmywLnaIPMaJaZZDdlDBWH0840x9hqANbYhQy0ugXGIbxb07Htka9vBW0O
 Oj6ClR+adaufaqR+jPFP+7Acr0S/+u6UcDRIF50I4+aZ1lyRSLy9/D2maahXoSilfF7aqXrYAA
 AA=
X-Change-ID: 20261019-qce-fixes-aead-e229fa2015e3
To: Bartosz Golaszewski <brgl@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eneas U de Queiroz <cotequeiroz@gmail.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Demi Marie Obenour <demiobenour@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Russell King <linux@armlinux.org.uk>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org, Pankaj Patil <pankaj.patil@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4027;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=9SmK/a7pYcCxWS3GjVR7mF4MMQ+9o9U9EbjnwSAG0Ec=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq12LLSsT8ijo536Kr2PkhXNVQXtjWYrWtLZygk
 IAcAHzsE4uJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCatdiywAKCRAFnS7L/zaE
 w6uWD/9xqQcA4sfVULidrbG+1ZK96dDcE9jqEmkGd2l9OEaLvZFeuED7y3/j0c8AQMSyJY9syIM
 S1pM+WjIohiXyWwQEjr0yNMXgsZOxcxuNWyFSiq9G8MC9gvxgiTQyET7Ct1E6XNU3uySIaxUtGF
 JJUPZK1vdhZZ9vE46zR045xDDXI0P/WGlnPGzF6y+uaG6YVUam1UzCY1H2Ro+qzOpRV1e3MsAH3
 3ttUnvctXiBV79RImNW/CM6gigX4rJtTX1oJ+MqN5mdM7YaDNmNwvKS0ttnZOUyLtj/pyf/KVAE
 305g/kbPQ78YwEJwDj086Q8ey+WpFzcsKeB4zaAvspiN1Kyqd/6+wo/G8UOXj95TagmRJSrmj83
 eMDfKvZeFEmrxfgCtGvVz1GcxtvV466AgvyX9JpTi5sdntB846d2xMAY3lIShn5VO331Ei76oP5
 v1OQNAKI8odQ+7plPJHF+SxulKXPssZ5zXmR5XHU5BdiDXgxjUIu0g2ocGsvv7TbJrXIfDFleLn
 QhdUEc37emrd0uSeHg/49HgW5iOXbd7IWuEdDP8MYKGPGZoJobqW5SJg+m0tBYPwMhBJmgookD3
 QvZbGSV0CUEieI/JlYEzvYP70eRQjodJqx3rbpmPeK26aue/ozMWMB9cu9j5GEDy0tFxPS7FuSp
 gQ8oyw0qrLISroA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: gH-qvlGyazcGECYRGeN5fcXeXw0aFf7w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA1MCBTYWx0ZWRfX+ys0003Hd82o
 j3rdTWKa1oGdrRDyabpoNiM3k8p3F/aYwHCBKmWsQ8heh/l+OOwbyv23PRFcKPBoodpiTQkOEHw
 3wX8zYzvE10Fwq/w13rOVWP8qlAt2gndhDFQdM/w6K45fIpId5MC78ecfiphuBaVUJ5hCmA6iFP
 UjIsouFHE5DmCRTEfByJgw140Qdnhl0EE0RBWPybS+hqZnW3D4sZts6+XXihQq4VYB6+Z9BtYcK
 HPn73hXGi+dWR6oQEWoVfsS1odaKcKXRHyFSa/IRbjzrHXUN4C9AJQ9C0FohUCnfPu1NaQSorab
 IztlQzqnQi01AXh/Co143xx9/1X/P4EV3LCNun8g/WI4SkqdfwpgmhYuNV5c9pOb3X5QAJNt34p
 Kc977DNEO2Rx6Qh+vpaD1TPLaBpSQFKk+0S89jl+1tQS1oCSFJFDo2EPkZxDvx1WXcL0+D0szcx
 RI5cQtwlUJqdhuPKzUQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA1MCBTYWx0ZWRfX4ZDs35EBIW2Q
 e2MLs/ffKTAUm+E8vu2gZQhlSwZSgng89bBT4fTKhlSL94r8Z0zcwtxAui16Z5SxC6yRQ981nFa
 k+WM4Gm2Nz2wy8WsWLQlfgdj7frKp2M=
X-Authority-Analysis: v=2.4 cv=LpcHWXdc c=1 sm=1 tr=0 ts=6ad762cf cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=iK5QPMNa_E_FA8V_BHUA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: gH-qvlGyazcGECYRGeN5fcXeXw0aFf7w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200050

As requested by Herbert: this is the aead part of the QCE fixes sent
separately for easier review.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v12:
- clear the ctx->need_fallback flag for key sizes other than AES-192
  (sashiko)
- Link to v11: https://patch.msgid.link/20261019-qce-fixes-aead-v11-0-11c55cc7a695@oss.qualcomm.com

Changes in v11:
- Split out the aead patches into a smaller series for easier review
- add a patch fixing a race condition resulting from sharing
  ctx->eed_fallback by concurrent requests
- Link to v10: https://patch.msgid.link/20261013-qce-fix-self-tests-v10-0-57162a38a554@oss.qualcomm.com

Changes in v10:
- don't pass a NULL buffer to sg_init_one()
- fix byte order of the imported hash state on empty finalization
- don't recompute the CTR counter in software for every request
- reject skcipher requests with a too short scatterlist
- check fragmentation for empty CCM decryption requests too
- don't use a static loop iterator (duh...)
- initialize the return value in qce_handle_queue()
- Link to v9: https://patch.msgid.link/20260922-qce-fix-self-tests-v9-0-b1aa742e79af@oss.qualcomm.com

Changes in v9:
- Rebase on top of cryptodev/master
- Rephrase Kconfig help text changes
- Link to v8: https://patch.msgid.link/20260921-qce-fix-self-tests-v8-0-107537869a72@oss.qualcomm.com

Changes in v8:
- Add a patch making the crypto driver *not* register algos by default
  but only if the user explicitly requests it with the provided module
  parameter
- Use the "offloader" name for the crypto IP instead of "accelerator"
- Fix device module table issues
- Make the core driver use a list (despite it only having a single
  member now) of child auxiliary devices to register to make it clear we
  have the intention of extending this once we start the work on secure
  media playback
- Link to v7: https://patch.msgid.link/20260910-qce-fix-self-tests-v7-0-cdbd2718af14@oss.qualcomm.com

Changes in v7:
- Add follow-up changes converting the QCE crypto driver to auxiliary
  bus, adding the core QCE driver under drivers/soc/ registering the
  auxiliary device and removing the BROKEN Kconfig label
- Link to v6: https://patch.msgid.link/20260717-qce-fix-self-tests-v6-0-455775fe5f6c@oss.qualcomm.com

Changes in v6:
- Handle all zero-length HMAC finalizations (like imported state with
  data already hashed), not only the genuinely empty message case
- Add an additional patch addressing the fragmented skcipher payload
  issue
- Link to v5: https://patch.msgid.link/20260706-qce-fix-self-tests-v5-0-86f461ff1829@oss.qualcomm.com

Changes in v5:
- Dropped patch 1/8 that's already queued
- Use the pre-allocated fallback ahash for HMAC transforms (Herbert)
- Link to v4: https://patch.msgid.link/20260622-qce-fix-self-tests-v4-0-4f82ffa716c6@oss.qualcomm.com

Changes in v4:
- Remove remaining ECB and DES3 bits
- Pick up tags
- Link to v3: https://patch.msgid.link/20260617-qce-fix-self-tests-v3-0-ecc2b4dedcfd@oss.qualcomm.com

Changes in v3:
- Remove even more algorithms and dead code in patch 1/8
- Link to v2: https://patch.msgid.link/20260615-qce-fix-self-tests-v2-0-dc911f1aad42@oss.qualcomm.com

Changes in v2:
- Add fixes for the full suite of crypto self-tests
- Add Fixes and Cc tags
- Link to v1: https://patch.msgid.link/20260610-qce_selftest_fix-v1-0-1b0504783a46@oss.qualcomm.com/

---
Bartosz Golaszewski (3):
      crypto: qce - Don't modify the TFM context for per-request fallback
      crypto: qce - Use a fallback for CCM with a partial final block
      crypto: qce - Use fallback for CCM with a fragmented payload

 drivers/crypto/qce/aead.c | 46 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 10 deletions(-)
---
base-commit: 0aac16003b01b9282491ea3d454697c2dc7e8c78
change-id: 20261019-qce-fixes-aead-e229fa2015e3

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

