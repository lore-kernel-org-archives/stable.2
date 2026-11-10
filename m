Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286479;
	b=a5bxOABfLZodoqLyVScz7uv1wEdBSQF5y8TKCx/i1zVPWo7IvVuxrhsjS2H34dvZ03+9
	 q6UlOGCC7V2uqwVbGG1fEJbyRrHX1tqMytxjo+trhBR3+mmm7z3cJDBGKUJXqYAn5fzD2
	 Q0hnWZYc4KfQlWpFrtM2bZJjCxgc8wHRH7bnTIgSH4JSDN4gLEUtgUY1kK+16jXjm1KIa
	 Yc7EIOCFINKAcoobsDyKqbHgCZaaNNkwy6mZmysPAUxe1don6Ue6w+JGI7lxMAIy/mFpE
	 uEKTH6g4pJivSqCJNRqufSl8r1XLZgHUEdAq8eCDQuptFyaW05VGzgnw9wctWUvyE6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286479;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:
	 Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=/uQ+PciZKgM4MpOioR71b1I3F2UT2QOM8zaZyK6f/dc=;
	b=lF9fRvrYGmXukIXIwkPwtVaKDIZZbijaxtQ5r00tOls87Xdq5nRENgVv3uCUOvyXCjKy
	 CXgtEtrqTimAOt/uv9kyCMvKGQAiLyPHBKAKfFdcCzBTpNhuep8c8NnTRtpB8Gv2CAnyy
	 n+iHJD76opG2rFSCGxTdAlW7dKhMMyAQddcwhrEz5q+cSRfyuNES7/t/KWSOVAOXrXCf/
	 qkWTuUR/X/U+dj54k8C9DiTIlY8HMtrSEpoH4fZzzpBhVMXT4Xf7/KQ4tK+PQLd+Xkqe1
	 5jVw+Rn3EiX2LhKozu2lL84n2b5IQERmOzSGTISHQTljkzTT+71GaXyl5vXPyGTcR5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PT4G2fAc;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SkXx1xPW;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94D9606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B94D9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PT4G2fAc;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SkXx1xPW
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA4A1A52249122
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:54:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=/uQ+PciZKgM4MpOioR71b1
	I3F2UT2QOM8zaZyK6f/dc=; b=PT4G2fAc0zrttoF9IexP3b6NnN8+XPnIiW2kBk
	JcQqdpw/TUVNiS4cdjdhxqzYn8AWjUsftrMIuOn7744dSyS8DJxC9J7SCkqDS46f
	J3VXINrv3jQXyCA7eU0kKwm99ajb7JBi/dQXcmhvBEH6Yfoz1p7n3Ds/ncYEvtwj
	kVBiJkN5rUiwiUC75MV0Njhg+qcB4uJADq99XfJW4OVNRr9lxheb268JEr5SQLj9
	OVeNJdak5/Pu8tMAPRNFS1Wh5Bwcbiy2l9Fw0Zo5P/5pYMa9542t6JH2crC3l+ka
	rtGmeOKEnoM/NtQFOBi+hdRL01TQMPs9hevqgTsoJp6W+6Sg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucapbpnj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:54:37 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f5844cb60so324470285a.0
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 20:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794286477; x=1794891277; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/uQ+PciZKgM4MpOioR71b1I3F2UT2QOM8zaZyK6f/dc=;
        b=SkXx1xPW4QafEXHAU7DIUPLWETXC3DXOgVltyF8OfVmerQP9JLN1zRfKOP6h+3aeF8
         qJGQDY/IAKz4zEcgHhxiXwD2gCzlvfahbNebsAOPMKwS0eMr2EsvLHmD2IEM0+bxCSA2
         8UQRkuQlYoXL2Jmd6CvKlU1cO17DVi1MoKRTg8Q80LCK8ROs1VGXBkOJpSh+EbGT0l3r
         Fh4aGJC7tGMXnULO5Ckb2h7Y9kcC9rQc8wohyjItFHnBWibzxUI//WS96xyqbhh4gfbJ
         QM65nZIBltlS0BNiVdlbatPOpaRDl0kbKvp1IvSHVUp79awrpfWJFeJX8BWyf1C9NRC3
         flmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794286477; x=1794891277;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/uQ+PciZKgM4MpOioR71b1I3F2UT2QOM8zaZyK6f/dc=;
        b=pbSOjaMepHAhFIYq8orIN+0QbeK3vBJuDzAHwyBWOLrE99vvo+t0xPMjgapN7A8RiN
         XoS/HMRc+AeuD63I4pGseBfRO1S0x3GiZHcq+3xHhKSq36Nn8dFVo5O3ntcQX2Q7/pgG
         mBD0v633JjNi8OrLu7whRadpFP4SLSorZGqxv3nNLuYbAjQsDGq8z7OddenWlOAVNHql
         xcXOqdE8Pi9yPI8touhn9q8fECAl/lXRfV8C1jyQOzsEcjqqJCZPgSKHKCqsBILs2/ht
         8XC17NrrLTG1PPxsl4Ph9lpzYmigoCEfg0WVV6BWsnFBkQf4sbLHyBCiQ47qEEO65+eA
         SvBg==
X-Forwarded-Encrypted: i=1; AL+hErG4jQWxYBIQMaz5oCYrtZnv4vnmgqWDAs/vA5rIIYihs2gStuFIJSzO4iYOfUHNCIAiQGNQpqI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/OiBQ+1zLlLrL8csgAHvh8CuEOtR+9CSyIdBFMRboa7cGz1fdz
	QfSWygKhSaRC+JnmG8GorJMMZgiwfUBIEzjR8nXThNgynMxY8aMcZm9j2g1rQgAk4+U5EdHXIvk
	hEeWR+zDTIvygQuLcmB7sN634p5XlVKX/qaqLnxhTVsO5SydfuJgffjrvN0A=
X-Gm-Gg: AYBFou0FQ2/k92ngk0jXO2/jY72Jj+5AYS8mZpiREShgQsfs611jyp34KP1ITZCc9K5
	Eh6O+Sdi259DKvm8n3Qv4jRKVHUrqglFHvovm9gcTFm8HlC1izOM9Rf46RP/6l+Esd9P+9oLMJ9
	F5xxl346e1VXEGAdH2mNt32eBoRU9Ayoxu6rnTdwzK6IrT62svNHIJEGM3wDUN5TVK0gGJQcWkE
	jeDvMGWPyiPMfnXt09V+yCuTX1DJGOT6TWskK6+OLTsU/EHC64cSceJxvg+Hsqg2Bu8MKTwldtE
	xLRIHqfXidplyq4cUbK4qphvq6GVDjF2IUVAaLuBd4yetew0M7U2/lZrAnV4wac+XEXu3Dbf53c
	U8Y6ZQ6Mpwl/kXcZ8xesgqHo6/3K8bteLHkSNKbS+Zb5Z3WasiN+vWDSQFmBopePDG3X4GbeCd2
	0CJ9x+ub7WnCazzyEC0i5jT59OlbQIuYjx7MrM
X-Received: by 2002:a05:620a:1a0f:b0:944:2057:a091 with SMTP id af79cd13be357-9479f26fbfbmr245661985a.40.1794286476634;
        Mon, 09 Nov 2026 20:54:36 -0800 (PST)
X-Received: by 2002:a05:620a:1a0f:b0:944:2057:a091 with SMTP id af79cd13be357-9479f26fbfbmr245658685a.40.1794286476047;
        Mon, 09 Nov 2026 20:54:36 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9479e73b2d2sm138653985a.10.2026.11.09.20.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 20:54:35 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Subject: [PATCH v8 00/29] drm/msm/dp: Add MST support for MSM chipsets
Date: Tue, 10 Nov 2026 12:54:21 +0800
Message-Id: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAH6j8moC/3XPy27DIBAF0F+xWJeIx/Cyoqr/UXUBZlIj1XZiH
 KtVlH8vdhZW2mQB6CJxuHMhGceEmdTVhYw4p5yGvgT7UpGm9f0n0hRLJoIJzYAz2uWOxmM5Jio
 VlyxotMECKQ+OIx7S94q9f9zyiKdzMafbJQk+I22GrktTXQktTYjYMCWVFwygiVYyDN5546SWW
 vHoGMiF7jBnv5apq/3ShTMBtD1GmsYTxRn7KdPZUkY1ogOHxksLb0POu9PZfy1f7sr2SpZebcr
 TMP6sM8+wFns03gyFC4IpbiP6sv5xqzarTdDC3QmqCDxaK8ogXBzgiaA3wUp+J+giNI5HqaI+B
 Pesg9kE96eDKQIEy8FIbhWaB8L1ev0FkweTEAkCAAA=
X-Change-ID: 20260410-msm-dp-mst-35130b6e8b84
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
        Joonhoe Kim <26rote@gmail.com>, stable@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794286469; l=14739;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=wlsw3C6bw99wEI5/qlccjxrx08IsEjqDkJyp/tct/fY=;
 b=fTQnK5jiOhrsUinDlrdfM8nqrVr4YqY+fdNyOqY+iRRNz3PYOlyO0MsxEtPh45YjnC250SEli
 p3jAuR3FJYBAP1lje3YEmg3dwwMMQkjIXBPaYCR8Z9z1AGEJfkYorI9
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX9X5JEPgreCgE
 KrCxCCcbHuYcHw2B7ZvpGIj3eOIA1/Brnql4pVX5Eej6gMBHb3hBAp+0wtaTLOWHdYpmsSxnUJa
 lgHItmj6E8EjxEKHCiWZT04bES0EErPlG8BMZJamWXmzOnb4qX1MEa3Zwwpto1BDen4v8qi9/Du
 vgz2TgdKdAlplq7ZQ5Dou+II+ZUkk5vaROaLLiqAFZxj2ZK2maD1NSuMuBu/5vq3az7K2ZO0L0p
 63UDWMKFezZK4CvHb6Nv5ZWyLYvQf4H/c6g0pjpO32SPut1txMaocZAhyI/SPfL9BSzVzbYYCto
 ij9/0lmbXP3LYQl6PLobkjHKtl34/LFgUMfggohs/VWWMevGLvTxFa98pUz9qSKlS9FrhQvig7m
 ohiJct/iB0sAOS7ozIrXKwu/b67KRidDBdFqby+EA0eez4bYFQP3ZNYHSx4uxpaigJZuZ961Rkc
 iPmLqrBf0Hyca1POH3A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfXyI9vfCZybLTN
 ynQYMabrvWrqY0ijtxT00zzxxyIIzvVsK7o4KBQ8Q1SJQ2+Kqjw1E0qfTOnnHukQWOr94YSiK2o
 34NaftevMELBu/0lSSTq8H1tuShscw0=
X-Proofpoint-ORIG-GUID: CLMaZgLath5DecitL6kpcmcgM7OyHPaq
X-Authority-Analysis: v=2.4 cv=TaQDJhQh c=1 sm=1 tr=0 ts=6af2a38d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=z_i5WFFK-8ga3zmfCq4A:9
 a=Glr7RG19KHHE_zVI:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: CLMaZgLath5DecitL6kpcmcgM7OyHPaq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100019

Add support for Multi-stream transport for MSM chipsets that allow
a single instance of DP controller to send multiple streams.

This series has been validated on sa8775p ride platform using multiple
MST dongles and also daisy chain method on both DP0 and DP1 upto 1080P.

With 4x4K monitors, due to lack of layer mixers that combination will not
work but this can be supported as well after some rework on the DPU side.

In addition, SST was re-validated with all these changes to ensure there
were no regressions.

This series depends on Dmitry's "drm: handle IRQ_HPD events correctly"
series [1], which adds the IRQ_HPD propagation infrastructure required
for Type-C MST support.

Overall, the patch series has been organized in the following way:

1) MST controller support (patches 01-07): low-level additions for
multi-stream operation — ACT/VCPF packet transmission, payload slot
allocation, and mainlink MST mode.
2) Driver refactors (patches 08-11): replace the power_on flag with a
per-stream bitmask, factor out panel-accepting bridge helpers, and
introduce link_ready for explicit link-level state tracking.
3) MST DRM infrastructure (patches 12-18): new dp_mst_drm module for
topology management, DPU per-stream encoder support, and atomic
stream enable/disable handling.
4) SST/MST connector state and HPD fixes (patches 19-29): SST/MST
connector state management, HPD event routing through the MST
manager, per-stream bpp selection, and Type-C retimer guard.

Note:
Validation for this series has been done on the latest linux-next on
LeMans (sa8775p) and Glymur, covering both FB console and Weston.
Type-C MST has been validated on Glymur with MST dongles.

[1] https://lore.kernel.org/all/20261024-hpd-irq-events-v8-0-6ee949e7a384@oss.qualcomm.com/

---
Changes in v8:
- Rebased onto linux-next-20261102; dropped patches 01-07 of v7.
- Dropped patch 32/35 of v7 since it not needed.
- Renamed the controller's mst_active to mst_mode so that it no longer
  shadows struct msm_dp::mst_active).
- Dropped the driver-side slot bookkeeping; the MST helpers now pass a
  msm_dp_mst_slot_info table built from the topology state (patches 07,
  09, 18).
- Patch 01 (new): Skip sink requests while the mainlink clocks are off.
- Patch 02: Use DIV_ROUND_UP_ULL() for the 64-bit division in the ACT
  wait time.
- Patch 06: Mask the STATUS5/STATUS7 reads down to their own interrupt
  bits.
- Patch 07: Take the slot table from the caller; simplify the rate
  governor's fixed-point rounding. Rewrite commit message.
- Patch 08: Replace active_stream_cnt with active_stream_mask so that a
  single stream can be queried.
- Patch 09: Thread the slot table through the helpers; key the disable
  guard on the stream's own bit.
- Patch 10: Release the runtime PM reference on every prepare_link()
  failure path, and check sink_count before taking it.
- Patch 12: Skip the MST manager cleanup when dpu_kms->dev is NULL after
  an early probe failure.
- Patch 13: Use the DP controller's own device for runtime PM; return
  early when MST is not active.
- Patch 18: Report enable failures and stop the stream enable sequence;
  collect the payload slots of all streams.
- Patch 19: Read the old connector status in the same critical section
  as detect().
- Patch 20: Drop the explanatory comment.
- Patch 21: Drop the plug guard in msm_dp_hpd_plug_handle(); hpd v8 has
  a stronger one.
- Patch 23: Check for MST before taking plugged_lock.
- Patch 27: Drop the hunk that handled plug before IRQ_HPD, now done by
  hpd v8; retitle accordingly.
- Patch 28 (new): Select the MST stream bpp during the atomic check
  instead of failing the modeset.
- Link to v7: https://lore.kernel.org/r/20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com

Changes in v7:
- Rebased onto linux-next-20260918.
- Incorporate Type-C IRQ_HPD support: new patches 33-35 handle IRQ_HPD
  events from Type-C controllers.
- Patch 02: Rewrite commit message.
- Patch 05: Handle optional pixel resources without spurious errors and
  track each register block's size separately.
- Patch 07: Use optional-resource mapping for MST2/MST3 registers.
- Patch 12: Handle stream 2/3 VCPF completion through STATUS7 and reuse
  the existing idle helper for SST.
- Patch 15: Preserve the disable guard and adapt it to active_stream_cnt.
- Patch 18: Add explicit MST manager cleanup during KMS teardown.
- Patch 23 (new): Move link capabilities from msm_dp_panel to msm_dp_link.
- Patch 24: Propagate enable errors, update remaining payload slots on
  removal, skip disable hardware operations after disconnect, and use
  shared link capabilities.
- Patch 25 (new): drm/bridge_connector: suppress hotplug for IRQ_HPD
  without status changes.
- Patch 26 (new): drm/bridge_connector: avoid detect-based HPD
  notifications for DisplayPort.
- Patch 27: Route IRQ_HPD through bridge events, drain pending ESI
  events, and synchronize the IRQ before manager destruction.
- Patch 30: Use shared link capabilities and explicitly check for MST.
- Patch 31: Preserve SST operation for SST-sideband-only sinks.
- Patch 33 (new): Fix threaded HPD handler not woken on controller IRQ;
  Fixes: 5043357e75ba ("drm/msm/dp: rework HPD handling"); Cc: stable.
- Patch 34 (new): Order IRQ HPD handling: process plug before IRQ_HPD;
  discard IRQ_HPD on unplug.
- Patch 35 (new): soc: qcom: pmic-glink-altmode: skip retimer reset on
  DP IRQ when state is unchanged.
- Link to v6: https://lore.kernel.org/r/20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com

Changes in v6:
- Rebased onto linux-next 20260828; drop already-merged prerequisite
  cleanup patches.
- Reordered patches for better logical flow.
- Patch 01: Also move power_on=false into display_unprepare.
- Patch 02 (new): Split from old patch 04.
- Patch 03 (new): Split from old patch 04.
- Patch 04: Squash num_pixel_clks into this patch.
- Patch 05: Use loop for snapshot; skip inactive streams before adding.
- Patch 06 (new): Split register definitions out of old patch 04.
- Patch 07: Rewrite old patch 04; replace stream_id special-casing
  with transparent msm_dp_read/write_link() helpers.
- Patch 08: Fix REG_DP_MST_ACT register placement.
- Patch 13: Drop defensive start_slot bounds check; rename
  channel_alloc -> update_timeslot.
- Patch 14: Guard link training with active_stream_cnt == 0.
- Patch 16: Add locking annotation; group link_ready with status
  variables.
- Patch 17: Drop redundant stream_id >= DP_STREAM_MAX check.
- Patch 18: Consolidate msm_dp_mst_attach_encoder() and
  msm_dp_get_mst_max_stream() definition, declaration, and usage
  into this patch.
- Patch 19 (new): Split connector/topology callbacks out of old
  patch 23+24.
- Patch 20 (new): Split dpu_encoder_get_intf() refactor out of old
  patch 21.
- Patch 21: Squash stream_id condition; reorder before MST encoder
  patch.
- Patch 22: Use thin wrappers instead of renaming/exporting core
  dpu_encoder functions; use suggested for-loop style.
- Patch 23 (new): Split atomic stream enable/disable/check out of
  old patch 23.
- Patch 24: Add hpd_irq_lock; use %*ph for ESI debug prints.
- Patch 26: Defer SST-disconnect-on-MST-cap to new patches 28-29
  to avoid bisect breakage.
- Patch 27: Add comment for clear-before-write DPCD sequence.
- Patch 28 (new): Split from old patch 14; handle boot-with-cable
  SST bridge detection.
- Patch 29 (new): Handle SST connector status when MST is enabled.
- Link to v5: https://lore.kernel.org/r/20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com

Changes in v5(fix comments from V4):
- Dropped early refactoring patches (v4 01-12); restructured as
  "move link-level teardown", "factor out _helper variants", etc.
- Dropped v4 39/39 (platform MST stream list); use DT pixel-clock
  count instead per Dmitry's request.
- Patch 02: Remove artificial max-stream limitation check.
  unify register naming (REG_DP1 vs MMSS_DP1).
- Patch 05: Calculate ACT wait time dynamically from mode parameters
  instead of hardcoded 20 ms.
- Patch 08: Replace start-slot loop with direct math; fix commit message.
- Patch 09: Add locking annotation "Must be called with
  msm_dp_mst::mst_lock held" to msm_dp_ctrl_push_vcpf().
- Patch 17: Rename prepared flag to link_ready.
- Patch 22: Move drm_dp_mst_atomic_check() call into msm_atomic.c.
- Patch 23: Replace bridge-based MST DRM model with encoder-based
  approach; remove redundant bridge layer between encoder and connector.
- Patch 24: Add drm_edid_free(); add FIXME for bpp negotiation.
- Patch 25: Use dp->plugged flag instead of link status for MST plug path routing.
- Link to v4: https://lore.kernel.org/r/20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com

Changes in v4:
- Fixed most comments from V3.
- Rebase onto HPD refactor V5.
- Fixed casing/formatting issues, for example: "mst".
- Drop .mode_set() and set_mode in .atomic_enable().
- Rewrite commit messages that are unclear.
- Use the same API for MST link and SST link writes.
- Use the new drm_dp_dpcd_read_byte() / drm_dp_dpcd_write_byte() interfaces.
- Remove some unnecessary payload fields from the MST bridge.
- Remove some defensive NULL pointer checks.
- Reworked the patch order to make the series easier to follow.
- Add support for more platforms.
- Link to v3: https://lore.kernel.org/r/20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com

Changes in v3: Fixed review comments from Dmitry
- Fixed lots of comments from series V1/V2.
- Rebased onto next-20250808.
- Rebased onto Jessica's HPD-refactor branch.
- Fixed formatting issues in commit messages under changes.
- Removed unnecessary one-line wrappers.
- Relocated MST-related .atomic_check() calls to their appropriate positions.
- Removed the logic related to slot checking in .mode_valid().
- Link to v2: https://lore.kernel.org/r/20250609-msm-dp-mst-v2-0-a54d8902a23d@quicinc.com

Changes in v2: Fixed review comments from Dmitry
- Rebase on top of next-20250606
- Add all 4 streams pixel clks support and MST2/MST3 Link clk support
- Address the formatting issues mentioned in the review comments
- Drop the cache of msm_dp_panel->drm_edid cached
- Remove the one-line wrapper funtion and redundant conditional check
- Fixed the commit messgae descriptions of some patches
- Reordered the patches and renamed some functions and variables
- Link to v1: https://lore.kernel.org/all/20241205-dp_mst-v1-0-f
8618d42a99a@quicinc.com/

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

---
Abhinav Kumar (13):
      drm/msm/dp: add support to send ACT packets for MST
      drm/msm/dp: add support to enable MST in mainlink control
      drm/msm/dp: no need to update tu calculation for mst
      drm/msm/dp: always program MST_FIFO_CONSTANT_FILL for MST use cases
      drm/msm/dp: add support for sending VCPF packets in DP controller
      drm/msm/dp: add support for MST channel slot allocation
      drm/msm/dp: replace power_on with active_stream_mask
      drm/msm/dp: factor out _helper variants of bridge ops accepting a panel
      drm/msm/dp: add msm_dp_display_get_panel() to initialize DP panel
      drm/msm/dp: add HPD callback for dp MST
      drm/msm/dp: mark the SST bridge disconnected when mst is active
      drm/msm/dp: enable MST on capable sinks
      drm/msm/dp: mark the SST bridge disconnected when an MST-capable sink is present

Yongxing Mou (16):
      drm/msm/dp: skip sink requests while the mainlink clocks are off
      drm/msm/dp: add link_ready to manage link-level operations
      drm/msm/dp: introduce dp_mst_drm module
      drm/msm/dp: add MST connector creation and topology callbacks
      drm/msm/dpu: pass msm_display_info to dpu_encoder_get_intf()
      drm/msm/dpu: use stream_id to select MST interfaces
      drm/msm/dpu: add per-stream MST encoders
      drm/msm/dp: move link capabilities to dp_link
      drm/msm/dp: add atomic stream handling for MST
      drm/bridge_connector: suppress hotplug for IRQ_HPD without status changes
      drm/bridge_connector: avoid detect-based HPD notifications for DisplayPort
      drm/msm/dp: wire MST helpers into atomic check and commit paths
      drm/msm/dp: wake threaded handler for HPD IRQs
      drm/msm/dp: ignore IRQ HPD latched together with an unplug
      drm/msm/dp: select MST stream bpp during atomic check
      soc: qcom: pmic-glink-altmode: skip retimer reset on DP IRQ

 drivers/gpu/drm/display/drm_bridge_connector.c |  23 +-
 drivers/gpu/drm/msm/Makefile                   |   3 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c    |  51 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h    |   2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c        |  37 +-
 drivers/gpu/drm/msm/dp/dp_audio.c              |   2 +-
 drivers/gpu/drm/msm/dp/dp_ctrl.c               | 320 +++++++++++-
 drivers/gpu/drm/msm/dp/dp_ctrl.h               |   9 +-
 drivers/gpu/drm/msm/dp/dp_debug.c              |   6 +-
 drivers/gpu/drm/msm/dp/dp_display.c            | 388 ++++++++++----
 drivers/gpu/drm/msm/dp/dp_display.h            |  27 +-
 drivers/gpu/drm/msm/dp/dp_link.h               |   2 +
 drivers/gpu/drm/msm/dp/dp_mst_drm.c            | 679 +++++++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_mst_drm.h            |  18 +
 drivers/gpu/drm/msm/dp/dp_panel.c              |  34 +-
 drivers/gpu/drm/msm/dp/dp_panel.h              |  10 +-
 drivers/gpu/drm/msm/dp/dp_reg.h                |  17 +
 drivers/gpu/drm/msm/msm_atomic.c               |  14 +-
 drivers/gpu/drm/msm/msm_drv.h                  |  47 ++
 drivers/gpu/drm/msm/msm_kms.c                  |   1 +
 drivers/soc/qcom/pmic_glink_altmode.c          |  38 +-
 21 files changed, 1599 insertions(+), 129 deletions(-)
---
base-commit: 2637bdec0535a2044cd830eba9a79363651d9043
change-id: 20260410-msm-dp-mst-35130b6e8b84
prerequisite-message-id: <20261024-hpd-irq-events-v8-0-6ee949e7a384@oss.qualcomm.com>
prerequisite-patch-id: 38205d2013335920df343c240fa0afc17b987763
prerequisite-patch-id: 358e5f35d442041b88e52d8e39a564a053a0f990
prerequisite-patch-id: 9860b9acb12b1c2652e4e9f4860968a2ca3361f0
prerequisite-patch-id: 53486e695198f785401740f7f4372bdf335fb620
prerequisite-patch-id: c8e551a07553f7dc107063a1dbec1d415184f97b
prerequisite-patch-id: 1a6251919897ca5e8b12a63774a833fd8460c67a
prerequisite-patch-id: 846ab694795c6bec123d1dc46d7a53097bf594bf
prerequisite-patch-id: 2a058aa8309016f424b1d4ca19a9b20e92f4d8b6
prerequisite-patch-id: 76ea1ecf4e1d83ce2e5730aa36ed1a4524f15e56

Best regards,
-- 
Yongxing Mou <yongxing.mou@oss.qualcomm.com>

