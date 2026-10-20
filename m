Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792500438;
	b=y2hZBDPCeKSd53bcbgZoKeophZWptkby7FVPPjQ1ei0lUHjjhlCIADAyX6U/AOgQ6qDp
	 I3jo2gnVyRPYMWUejWj21H8DmvexfBWE1TvtFttilwXZpxdoaeEoeoxHGNsk++xYxXcg/
	 z2FbCsfF1T8eN5/tT7JKQNh5CzmEjZHxDDLYabt/WduWAgJzE5M7KKweiaGSog/5UkxNq
	 W57Eqdzx+r83Ms6DsVgDtshHP3TaZtJkEk6bq/24rFij/dR1/4B/79xz+E98Y1qeRTpJx
	 +duxtflthc+ZqKF75c2iS6uWScmH32ziOFWUYQt001SUNou9728AwV4VO7+8FMJY/LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792500438;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=huFKBQDlZuVavcX0HkWyC9IVz+ofFZPmUDE2CCpGGhw=;
	b=ABXl5H9LXsn+H6HPhQ5CyPYed4x7Q/sQEH5jEomFr+6otp4r37L771l8+rE/gRPbsHk4
	 bFAYPO64AjxHGxSvCf63qzHJKcY99PHtSum8L2vUhShLkhvLsAb5Cjh/+NL7FkhJ4ycfM
	 A3l7/1kepvinyYi1lWjdmV44Vl7Cr8GZVXWwwu/N+y79GsZIJl6EepwdvEHrc4mDdKMjM
	 3aykoXmN9CsyJht0mklkEDTYD2E7f29pVQ9aUSM8ZMeewr13bWjeTi8uEjm8ePvdV0dCv
	 n+bVz6imFtS09bjbTIqk1wtdW6cLpaPZB6YQlX63lSMZs+ZFE25PAVMvykUYY7jzFSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M4rHAd6D;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HLV5jyKx;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7002160A3804
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 12:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7002160A3804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M4rHAd6D;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HLV5jyKx
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69KAx96T419814
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 12:47:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	huFKBQDlZuVavcX0HkWyC9IVz+ofFZPmUDE2CCpGGhw=; b=M4rHAd6D1FJIOzeo
	ZlW02DqDIcBFHQK6ttTi+6nivdTF7yZq0PqRV0LJm2dZlqM4C5u34Ix2frU8xjwe
	78t+MkIw2EfvFDGCKB6MBPrNjb53Fts94lMPa4+NX8KcNybfeXY91La5cIRo/3/U
	aCiylSbMA3wbLsQJOxHJVBzp7JOBGFq1zlgaVjs0AVy2wvPv2rSmRzrrfyW6/DOa
	lb/SBoqCszMAq+9orbVa1rQBgQP4Lj/1nyGsXiqc0TJ+pX0TaL7bLSSO+0QRetbn
	LMu2ivdRQv5ZZUERp9C8vrQNpKWu3KVFexTwoKSf88G7SJDU7too5zMDxr/EcUHw
	xT7bwg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5stf84-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 12:47:17 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-917a3c27c9bso53706046d6.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 05:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792500437; x=1793105237; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=huFKBQDlZuVavcX0HkWyC9IVz+ofFZPmUDE2CCpGGhw=;
        b=HLV5jyKxFGVxD1OAThqrzqe+0u+x5aWPYXjXPpjFoEBacG0vk+K50+PyvXLApAjkqC
         AAB6IsJTHGOqO1pFJMotND7h0/Bqy/A82Eog9I72KwYo9wCJSNcR6vApo8PfFQJWnXXU
         HQzheh4/XpoMy57e78tEABZvfkMJy97dZtGuUCo335enoe5NeLkUtS8iFqjgDoaypKby
         DGS0Y42XHZS7nY5Hmw20Hw1D+hGvIw4LntYTc/CSJNt+eK4NverIE9TNNTuWOwrG1yi3
         woTAhM9l9eVvvV1f2ChtUn52CQBNZ+7+K4KUKXEuz/qZzFUTbODALqiDCFo0ATU114aA
         Nu4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792500437; x=1793105237;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=huFKBQDlZuVavcX0HkWyC9IVz+ofFZPmUDE2CCpGGhw=;
        b=oKlOixXweWdsEj6d2WPIqxj12ycgofcrGosv5Yar+K84SDtpyRppVBEIhKNWWnzX27
         KDZVjDnkl6+eYie6puRvjqb+JlK3Mz9962JLcYP7/w6frDbFC8xIiLm+dsTp+049c0SX
         A5d7qhD4uZPf8ja19XBXTB7Fpaab66kOuKRXfUDiWrg/SEs8KNYwj9dlzurhITvfh89A
         HTvKexoo/ZH7u3itBn6FcTR6uCVcJFEjdguWZjOy8X0xko4mm0IXcomdvwXMOb5sAIbw
         Hyqjckj9T8J8zwbg1kq72zymbej9y0kdVFl+DECRpc5jRE3d9nDXM3S6OVZXdfekwrPe
         fuYQ==
X-Forwarded-Encrypted: i=1; AKwUvBzCbMQ0swRD6xb3RzLCKRnZPpn4jO2A+i5m/5G9DHp9raclKMNFGpUX6KWWZLG/E1Wo9YpCp/s=@vger.kernel.org
X-Gm-Message-State: AFq9FYK27TNPpUAgFWq5AuDqf53lmD+vla+eVOULa9BehySRZvpHITfF
	Kidx/qCaI4GftQjHcgvGTenAu0QkoAiW3QZqbOshLjUdYSrNkiI2w9cT69D7ooEJMarWuQ6NInt
	Cpbpy8Ba6oxQ3Pkkf+D+3Dadvm4Dd39OWmdQCh7dOXg8tY/561KHK6LCGHY0=
X-Gm-Gg: AYBFou39YIFDXOv34MHRnsGFGJLKfO7XT0eJDGGnmsyWFWkD4pHkzZi8upPAJEIskUz
	BJqHogzsqZnmI3j1pOOXARVgHxyZOdrA3D+i74G5wiL4sGrqoK305Ua2fNH+/A24YiNCi8vHHKj
	LdU5rx2pKyQ1b9tWjZnLlCO4O1dtQhku2mIWfm1XXGHmUDdIhBPREki0N1+K7LaPxo5HeiDI5ZU
	spRf7SQ2EYqyl/+0nOG0rL9jD6NQhtE45xANoibiK2ZhF8S4E5GsSEKnPXUGtCynlRoKYfARhxH
	R0Jzeoz3Ez3qb0x3JO7Dgpkh24HHVbu9BFamivRIeY2qh7jerGP0HsPtst59ZWsBRiVLoscBj1e
	AlQBWXamkz+xAyzmPpyDx2UWQTw4g
X-Received: by 2002:a05:620a:288b:b0:93b:d7a0:d9e5 with SMTP id af79cd13be357-93f29dc760bmr1784980785a.63.1792500436758;
        Tue, 20 Oct 2026 05:47:16 -0700 (PDT)
X-Received: by 2002:a05:620a:288b:b0:93b:d7a0:d9e5 with SMTP id af79cd13be357-93f29dc760bmr1784974985a.63.1792500436235;
        Tue, 20 Oct 2026 05:47:16 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d82456asm6544253f8f.42.2026.10.20.05.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 05:47:13 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 14:47:02 +0200
Subject: [PATCH v12 2/3] crypto: qce - Use a fallback for CCM with a
 partial final block
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
Message-Id: <20261020-qce-fixes-aead-v12-2-77a2e09abd0c@oss.qualcomm.com>
References: <20261020-qce-fixes-aead-v12-0-77a2e09abd0c@oss.qualcomm.com>
In-Reply-To: <20261020-qce-fixes-aead-v12-0-77a2e09abd0c@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1628;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=GqhpiPEpEa1I70oxqqZo3K9AEP6IrLH9DMi8DVCLwIs=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq12LLD9DtGJXaTr9T04Ert0KoYT+bbygA4vMVf
 PJyAMr6eI+JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCatdiywAKCRAFnS7L/zaE
 w44hD/9clJ7ieqwrkF3q+9179egCOT3Rx0KvE4ovz+1T6uYEAT91Veqf2tZapFUdq8H+NqE5s0H
 OMHt1J5Lpd+vGnJaReYbYagXOBYNUST9ZXu5W9e4r+wptn0kDUWb7e9hp30K5xZ4O33ixIADjgU
 KoAOtZo0I5pJQ1CTXX2gSAOya8sf1/DMwRtFVNNIwXFi2ii69RJaXyq+iea08vFaFSAwIruZxyL
 B02PwJYSBfSithkOgsx2DcAmabxbfI5ZSEg6i04FtdlRpbK6VgekszSoAtXFrQLpMhBzjKsVjx8
 do2UNTz6vUcXLYmBQzN9gt4NXljvmAEElt/vWycQxpg4nNmMZqFdLeI4NqS3kvQf4MOJD9r9/vq
 V1SPA/CrSXWo4UqvOf0funuk14tBCTyPp8CvC/q3cEye/PqtyzNIOGsXkG8PmS4kDQcttuP+nK2
 L/un1xjZRxcDlcIxxXaevMqgIXUAVxP+cpYPil0HeHbiy6+uH3iVovuyVXMCmubczEL3nfh/+H3
 dzHhs2P39OgEHgm/UQ5De2zBP3/t9oIbbYG5IvAT9L6uLZEfpONWsJLHDNxUR9yUA6/tm3YTNsY
 FPFxr73LIOXY36roVVhOPsFYpV2QXwjba8P+D47SZEMPmKQ9rylbNRC2xrqj41NpsdWBL6SI6rl
 bBq2xfNNIfAoh4Q==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA1MCBTYWx0ZWRfX01zJTxkt/R7Z
 Y2TLZJBa9VwNHIGOTji4eQne//VpJYCnqrVFBMBBXoPso8HL45VVeUNAJ0UMLtAfZED1YDFY8vU
 2leU5kV/g1HrvszalXd7a/INykkHncZvR4+U7lMl/xKZEzf7nMP6S6akdtpm35fAopTdjHNUJL3
 yBOD5L2nqs+T/FFVQYF0NaaELx7m8/S6dyeP119Zl02EXOh0xHNreeWarIlufgu5qNaXdSZ8Kus
 COYQR/qLRUtxVoQwOkoamGcOGSEszy1kUVoQH0pPkMGGdt//V27HNxIVkvqdZfTddc8UFiT6soa
 2iCZPx8p3h5ngrnofJcAZdtasvb7Vc+OLBl2/7LwF7ZqhoACSslbWPMukaJrR6NRooS0m4ZhKTx
 Omjyl4b/vq2DSqS3ltzWbuwJxSVObC2q7pESNb/WRcP4tfR9u8ZMRrRinOjVQuNLdpUOburWPDO
 iTo/wEofshmFY5vLzHw==
X-Authority-Analysis: v=2.4 cv=fIusTpae c=1 sm=1 tr=0 ts=6ad762d5 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=dx2SfONCXZg6tt9xEGkA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: he0guxzgO3E4R9GIgChdZRYd4weIM6f6
X-Proofpoint-ORIG-GUID: he0guxzgO3E4R9GIgChdZRYd4weIM6f6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA1MCBTYWx0ZWRfX+CvO0M2H6JWq
 NNnwxaqF4RxNzXcp8ct7Hjs/+SSwVWDUPNbeOp1YLWgSpf2SPY321vg2NkJg1UDh1+GSQz0vHIx
 0F9HjAl6IH1CHh2cbYjSU0OnDzZ+hFU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200050

CCM builds on AES-CTR for encryption, and the crypto engine stalls on a
partial final block just as it does for plain ctr(aes): a payload whose
length is not a multiple of the AES block size leaves the operation
incomplete and fails with a hardware operation error. This was caught by
the ccm(aes) crypto self-tests.

Force the software fallback for CCM requests whose message length is not
block aligned, reusing the driver's existing need_fallback mechanism.

Cc: stable@vger.kernel.org
Fixes: 9363efb4181c ("crypto: qce - Add support for AEAD algorithms")
Tested-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Tested-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/aead.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/crypto/qce/aead.c b/drivers/crypto/qce/aead.c
index b7873852249dffeb91d09df3bae6534f77c08b7e..19d7e92aaeda0df1072114fa0435dc40e1eb6849 100644
--- a/drivers/crypto/qce/aead.c
+++ b/drivers/crypto/qce/aead.c
@@ -515,6 +515,14 @@ static int qce_aead_crypt(struct aead_request *req, int encrypt)
 			fallback = true;
 	}
 
+	/*
+	 * CCM uses AES-CTR internally and the CE stalls on a partial final
+	 * block, so a payload that is not a multiple of the block size has to
+	 * be handled by the fallback.
+	 */
+	if (IS_CCM(rctx->flags) && !IS_ALIGNED(rctx->cryptlen, AES_BLOCK_SIZE))
+		fallback = true;
+
 	/* If fallback is needed, schedule and exit */
 	if (fallback) {
 		aead_request_set_tfm(&rctx->fallback_req, ctx->fallback);

-- 
2.47.3

