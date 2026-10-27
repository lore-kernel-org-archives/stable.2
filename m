Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793108019;
	b=KheQ8Hubtjn29TAIybrJhvFFovaRPix7GpzGIyNbCpj0AcL3gqGbB/HJn+NADHAJXYct
	 aibiYoLzMaEkp81vOJc9oEYc4OMAESBqtTwq4r+C/gFChGd9ww+SESTux5E8Gz05nYHer
	 Xrhl8mE8lOCA0AOKQKMsoAZJKmYSXFRJ18BQa58NLXzO+FXOtuaZReeOOHqxYHhk0qI6J
	 87y8dZo9NiOSxFOcRp1Sq99YtIehVPTNcB00GAhMzcLiQ6JWkpdFTpxVnQewZHOkvhALa
	 xpcvxbxkR8wBNTTMy1NSZP3dujqm6EpEtjVttmRWVut53fAhpJbhgqMVi+pGDQ4OVzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793108019;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=VhTrCHgNWYcect8PsBRYG/AUQupaCriJbSZPutukaL4=;
	b=rAwmsS88w7n2Ne0pWmYmFufCvuIgHXJT5ECrktl0t+MDTLqlBGZNMrt9HMrQka11siGg
	 sD6sQW6v0u/ZUvQnIfrpKiuQukEMVZcTRYW/XN6B/nqpS3+FccSbAcs2pymty7NKSl5+C
	 Yp0V7X9MTmpGJh6po0wHXCMa41YQymbj3+9yS4N1i2N5urileaX8qnZjNpG0XeUj1clgW
	 E/imuB1oAFtk07cba8kTQNM9wPNfsP8HDSPZ60rXuyDGkmMW8VESgEKBepe4UFYx6eHn0
	 vS4f1oMGxSk5KMkEo7DS6C/tQ1E3gM4vEABUVmF+mWBDBg5DvNIQFNf7FPCQQf7+nng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cXQyxX7E;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YAAV8iuJ;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE01F606A31E
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 13:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE01F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cXQyxX7E;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YAAV8iuJ
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RAe3ru2524795
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 13:33:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=VhTrCHgNWYcect8PsBRYG/AUQupaCriJbSZ
	PutukaL4=; b=cXQyxX7EWtisylRynMs+ee5lUEWdoPioWw2HSYEyhvDCxMGzpwX
	+5aftycct+4vVHIJkhj5/3E4WJUYPmPwdFUwLqN3F5CRpnV3cOoukxa3Zhz8WqTY
	GLmIZpzRt6eTbe7/rxGYiBW8zhVQJdCnV1V1aYrvFwXaqsYGxN1ofKOK8D61Lt+I
	X/Xa36EXTA6byVR9wHZtMXcyrzqQXT7eO1ZFiK9SZJQacEUrIQS62SWCyl3nm37E
	8zERHzrOrryeGVOuFL+1ZHbrN5BvzABWGMV2EHnD7qYGxMMrrK0awmJJeS6tvmE+
	IA0hoA9PpnpTLLKLaArJEmp1RP9bYYYhMwg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjqw21avt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 13:33:37 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ab27eb38d6so3941429a91.2
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 06:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793108016; x=1793712816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VhTrCHgNWYcect8PsBRYG/AUQupaCriJbSZPutukaL4=;
        b=YAAV8iuJhVeXfJOB2te6lNryHey1pT0keX33pOuv7VsuE+g4mZcJtNayZPJ6qV31u9
         SVLoOFPtrJmv2Bofev89LOWCueCUVawSDDm8nWIbvzTBmxo2RB3/7aAmnqrHOUjWor8o
         vZIhXCKvZp0Ay1en+l62XZLHdOW7dRaw88u8GOJK1RE0fTKXJZ8ke9Yc586ul4R877LT
         CQY3enD2uQ6VDg2Vmw5FVRhDZw+lgbssYuLXwpVu7Q+vbOR1dhSx5JcPM0ewZ/DUDfhW
         GGnUizSoRK/OLeIZTJ7B/fDXR6MjtSo3S9Z2L4UItohS2/IIm+0Ks7bJDId/nA3ESC68
         oKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793108016; x=1793712816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VhTrCHgNWYcect8PsBRYG/AUQupaCriJbSZPutukaL4=;
        b=g9viRG/QJANlO0wKUnQlqpahNdpgu3PQNAkF5v3KEULKBhNoE1EiN77ICNoA+q0k5T
         GNIUUNxjYBVPzb3jSG7HcHmjwhytZ/GG4B2uS520fICMCoixRFFHMKF9y62slcl/0wtu
         K7vP+UDA4rw67rHfjFw1it9bH3j9cyr2zXCAxM/T6h9ziI5MtrdmyI1rRQZkDRLHjt6g
         HiVz8K1PGMWnoL8Dabr+NYMmepgeiA43KKvEOijXwzVWos1d8tm/E3tkeK6mncXb3IKZ
         Ri6Ng1oYulm9xlajSQTPW+1QkJszrNfwUWDcvjlyAJ8FkPCUOELYEFvW8MbdfgmPWZDv
         jGhA==
X-Forwarded-Encrypted: i=1; AKwUvBzPitv2vxFm+1FUbt09RVnmnZj/FOV9QP8oWg0ub7nCkAXtUaNJlk2v8yRswvlFuwk4I4yM1/k=@vger.kernel.org
X-Gm-Message-State: AFq9FYJDB7IrgyMdu3N8voc2OrnQCnoSouoPiZ0Fh/qfS+470V6o4RCq
	T7pa6PS+oxQUTAZ1q24BOJSC+enm9pg3Cn+zxvAuvRsatv/L+PosCdqFr7WOm44KZX+Uj45Bfxd
	fFHbT+xK9pPDBDTeWPmyiduJMUUZYXiz3hxKGtX6E6t8Y+G859b0C62BlCwY=
X-Gm-Gg: AYBFou0dfhZNp1FD4xCp2jxzTxkcUvPY4/a+b20gaBrCLJNhUlMfa/Cgwq0Gj6j7Gnq
	M1w2SBn85RvtK3ZCahOKXhnGeiFNhxDKCLd0ylG9LDCpxoaZ+ieg78BX/b2IsivswsF70rqzt5H
	YdXaztj/QSTBhUR+kaFLEUzadn8wy/+qFenj1c4S0fm6aRxq0gQVKyibvP1djbjhPCPu6pZxf0E
	HpxZ1B9kdV8VdG4gWD/2NBtxsSCBxsGcb20YvrjpO4MR8S68B0w8Kj/pfT+LGgaS0ZxjfXs1igj
	ceMBG0iyDchChK/Rsunfj91SgBXnL1MBwqhXYW+egquuGrHyH0GM48tUlMaCf4offFEPeX4xJ/B
	kUhQ7G20qAnB8vVQuUkyiVxyAdfQF+XACy4PT5O7UfVRwoK5828IG8070V41hAWnt3G35kKrdBS
	dCfmlWxZPs8Bqmhv3r5eSAEkIGncGhal7qwuUoyLA=
X-Received: by 2002:a17:90a:e7c1:b0:3ac:9a5e:9cde with SMTP id 98e67ed59e1d1-3adeabe0cc2mr8753249a91.30.1793108016194;
        Tue, 27 Oct 2026 06:33:36 -0700 (PDT)
X-Received: by 2002:a17:90a:e7c1:b0:3ac:9a5e:9cde with SMTP id 98e67ed59e1d1-3adeabe0cc2mr8753220a91.30.1793108015716;
        Tue, 27 Oct 2026 06:33:35 -0700 (PDT)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae4066d631sm4033195a91.17.2026.10.27.06.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:33:35 -0700 (PDT)
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
To: rafael@kernel.org, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqiu.han@oss.qualcomm.com, stable@vger.kernel.org
Subject: [PATCH] cpufreq: stats: Fix potential out-of-bounds access in deferred reset
Date: Tue, 27 Oct 2026 21:33:31 +0800
Message-ID: <20261027133332.377546-1-zhongqiu.han@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1MyBTYWx0ZWRfX6IqCDUDos6+y
 i6ipXF/nGeNPMHLUU6i/G06AVEoCaXY9oam7QcxgU9HDfoGRsG4M5v0EDRBwDwAuQd0e3rf3nui
 Rxchht8njXKvvwywUlcoWyL73QxDGpmp5nl1Dd9tcKNzlW5elyRDpNDCosAZCMunQ7nBJT6vntu
 5w24BMU1Lo+8Xj+dTnwTPFPyzb8r4h9IUUYZ3p3ErgTVu/n+v8Oo6ew4JgnWgK/rXgZOT8tQ5Lt
 WjS1oH4GwxlSB6kmXxSd1TfaxlhUCDzmoOrbMpPuvM+8kdqanWqD8HKtbpVkko6Lo2aVslVf9UL
 dCdJ3bFh2nlDd/NBWSaLw2YZ8BvNCwJdGawZZFybB26f/J8G5u4BWV1mKoPoAx42C/A2l+SngTm
 E4dylQ1tZEioj0SoiVnzixepMrkRJqk86nQuQJHeqF5x7lGUeF+k75Jy5zGssz0vDxh9kuNV6hR
 PGS5ku/QRlH3fuewTsA==
X-Proofpoint-GUID: 3kqAn7Zqt9OiSS02wqK2mRXggEpISiXZ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1MyBTYWx0ZWRfXywJnrsN+wsc2
 RA0VBppDBywuS8Y8TCFigQi6qw4QnDOsmGOJVooBFOkT70WGJ/i6X/0m76PMSOXEsBKtYaA/EW9
 gedkW9S1JHhfi+/1SrkuXiaD+VTFFNY=
X-Authority-Analysis: v=2.4 cv=PsYG/AM3 c=1 sm=1 tr=0 ts=6ae0a831 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=rmPzS-a5SAvYCXl-4t4A:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: 3kqAn7Zqt9OiSS02wqK2mRXggEpISiXZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270053

cpufreq_stats_create_table() sets stats->last_index to -1 if policy->cur
is not in the frequency table. It then stays at -1, because
cpufreq_stats_record_transition() returns early on old_index == -1 before
it gets to update last_index.

Commit 46a310b80bc2 ("[CPUFREQ] Don't set stat->last_index to -1 if
the pol->cur has incorrect value.") added that check. However, since
commit 40c3bd4cfa6f ("cpufreq: stats: Defer stats update to
cpufreq_stats_record_transition()"), the stats reset is deferred to the
beginning of cpufreq_stats_record_transition(), before that check, and
cpufreq_stats_reset_table() ends with an unconditional
cpufreq_stats_update(). So if the "reset" attribute is written while
last_index is -1, the next frequency transition accesses
time_in_state[-1].

Fix it by also returning early on last_index == -1 in
cpufreq_stats_reset_table().

Fixes: 40c3bd4cfa6f ("cpufreq: stats: Defer stats update to cpufreq_stats_record_transition()")
Cc: stable@vger.kernel.org # 5.10+
Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
 drivers/cpufreq/cpufreq_stats.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 670a10c3ecfa..e7ec16bcb67e 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -52,6 +52,10 @@ static void cpufreq_stats_reset_table(struct cpufreq_stats *stats)
 	 * reset_pending accesses in cpufreq_stats_record_transition().
 	 */
 	smp_rmb();
+
+	if (stats->last_index == -1)
+		return;
+
 	cpufreq_stats_update(stats, READ_ONCE(stats->reset_time));
 }
 
-- 
2.43.0

