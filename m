Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EFC341AC7
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 09:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504507; cv=none; b=GboolJsf+yGugbWujFE+b3DKXGlnkVInSMxVjIr0toUlmuMp2N0PjRoxwQdKAURsLC3iVJgq8IUnumQ9Wj2vQlr+JpAwHgxLOWRP+42Wi6p7OqTOqPpCAaxfZGzYoSmkpL+rvuYri75HORWh8hYCrOK8SOom2shscbKi6qb7VwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504507; c=relaxed/simple;
	bh=KielJ8Do6FmcMys6V7ITutZj6HmUGFdwmlvbCq9I0z0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B9MRKSqCStsFFtoBLJrapVj/tkmZlTGIJsjdDA4OihzGWq/pzqvn+cAbaJz+X/62aTH3z9K2+wp/J/TvSNpiz/5pxYRDRcropHo0yPbdMYHOcnGA2su1CSbyoz1prsA8B7igSGUNFaxwkmhaUkzCiigncOpb4lw+xWs0ReDNSLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gCFzEmTi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bWutgNsF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gCFzEmTi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bWutgNsF"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66889BJd2070700
	for <stable@vger.kernel.org>; Wed, 8 Jul 2026 09:55:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=b5CFcTSvyTJIGcqPesdkFer5wgVsdpvvSq1
	HRnCCug4=; b=gCFzEmTiqyoZcqelq1j9vWPMLCpYXgkFmXbvJq+YwnSnq9tYkde
	EeUX3Nh177/borQR8qUJ1a/MY7HfvpKbL48rvfDWPhplItEcJ9obG2flkK9WsC6F
	7FPBZ/Wq7fzbOHH3XunNZvbcqUyFAt0tIRil39ZqTWTxDSanPKeRbH7ZuOeABH7j
	BNnX/03SzVUb9QjY8li5HbOc/IxaGRKLuVbElwfuPsxmEOoO+bjFGSjqkXy6evpK
	ohKb3HaoWfv1t/ZyDpeadP7h64KHX1S7YzVwqPC6th3dBtwlT2UivzHRhiDeRQmE
	H1hMlJIuLCpooherSEN1fMl0dHrb2CCyg2w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9be5a2p6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 08 Jul 2026 09:55:05 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1eb52e1fso10321751cf.0
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 02:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783504504; x=1784109304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b5CFcTSvyTJIGcqPesdkFer5wgVsdpvvSq1HRnCCug4=;
        b=bWutgNsF+rtnu1jcfVoB+LIrD7S7V7aikfyXCujKIQ3zSmVtUG9MrA1nyrEtX0l9jx
         K4Th7BFDgJq6bLcsDcmyqZ921cN6/oOOY6rHiNhsgpt1P2AOAytyf4kg5IfRRaNueWAX
         +H5thBo5UP4gtZ94clrDa9W3hYUy7DLWge0+KNCUOJoIncpJD+mjex311yGjgG07hRgU
         XVNhlkNb4aZJt085EL3yzjgBsYASfnV4XygMEp9vzmAy4g/9XjgblbNg4pTpZvgKGiX7
         e9r/ylufgVNBrQwjOiS6RrJytoftEusNWxmjFoYGm4FysOOYGTFDAhzv69iHc/VIr9tZ
         1LqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783504504; x=1784109304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5CFcTSvyTJIGcqPesdkFer5wgVsdpvvSq1HRnCCug4=;
        b=nY4aWB+3zc+ymIh0h84tNzB37TBCgDb6W+6AnHFRDWWmRoPpkiO0q35eBQuoxEUeC/
         60+BNmOUIzXtfX+P658upMcnr1mKeVJDyuPrR+OCKPZjypv+OnYvl+IWe0yOGY6jU0tr
         nhBZQ2DVgkgKv3R3K1HlqQe7ZoJgnCSAlX36/l4kpOvMNUooT3Ibz7TCw8dYOuSz3MbK
         irctjxTI5qpE5FdbZQybJj/KJqk0lHjOOeYm3ZvFqI5QvGlcE3F4QNTxUFEgjeGVASKd
         UZ2prtDnIBDdI+CA3VtwMbXOyiFCK2Eofct8hG90PoEHxRW7NkUKeFxqRq8rVehQhaIt
         gv6A==
X-Forwarded-Encrypted: i=1; AHgh+RrlkodqiZFGNiqH/xA6jZIx7sXuxAxfXSEvEcpR1DhxUYT3qT8FzXKLlSwMdWFNxX/U8B120w4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX8h+GUdo1SwX+BIxvgTMAmNr+L7JplqH9VqpB2KvqSYaL60Oy
	yxITV7sZrCdsfi1r/I+2jsw1iXkrztIX6qV+KlTz0RklCGYIqWNGVpOFXQqjlKGclg/VF09/YnH
	LcgaizFg1lRVzORCPSXdxn01OcVeh3ROaoANy+vRYPolUvtyS9ee1lNpAwk8=
X-Gm-Gg: AfdE7cnQ0BAL87qAMLa5QFj98VEbHmvSqSequufxo66DoBQKJZcPwBneqWIB1AZb+O4
	ba+fjkypUGYzOy38m99cBsNspW6QLlKgk94WpCy170bhBDU9K3tv/4i0k0IMAx/L6FLtHEgtqU+
	Q/DSGlOIctUBK72cZLh5MC1AkJNwKOSYokkKFzszpAvYPmTYdPgoZDnxKGmwdxbMe7Ft5SOyga0
	WKPOqnmO7jHYzqwrYDOoMImk9RX65/4UWhoclgqBkj3oHRMkTvg6fDOOLeQoCyWsVL0J5fRAd72
	QkPM0YdZhuhQ5v8uj6o9beXvamlBopgDcc/ZP1s0zAUPMU/qKEaf5uPvMNgJw+59cxIF7KAmGHM
	tIdEj4MyctFc6cNHez5+rNQK32aDEh4xPVW0Nxw==
X-Received: by 2002:a05:622a:28b:b0:51c:100f:f91e with SMTP id d75a77b69052e-51c8b409e16mr19480991cf.72.1783504504295;
        Wed, 08 Jul 2026 02:55:04 -0700 (PDT)
X-Received: by 2002:a05:622a:28b:b0:51c:100f:f91e with SMTP id d75a77b69052e-51c8b409e16mr19480731cf.72.1783504503907;
        Wed, 08 Jul 2026 02:55:03 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:6d02:5f1c:554:8e46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e582d4f7sm43946795e9.2.2026.07.08.02.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 02:55:02 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Shuah Khan <skhan@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>,
        Albert Esteve <aesteve@redhat.com>, Kees Cook <kees@kernel.org>,
        Alessandro Carminati <acarmina@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH v2] bug: fix warning suppressions with kunit built as module
Date: Wed,  8 Jul 2026 11:54:58 +0200
Message-ID: <20260708095459.12111-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GJc41ONK c=1 sm=1 tr=0 ts=6a4e1e79 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=c6gkZtNT5E4R2uqjZHUA:9 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA5NCBTYWx0ZWRfX+3BZ74RyCAci
 +UkTU5wZqQvYnLQRbj+zfWxzNevibPDv1++Ta3tIEgfbo5p3v71z9E472ZP8TcshCRl4geqedJf
 qTKaNaTiU4L3j7NWDZqiIrXIFSJHfZs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA5NCBTYWx0ZWRfX5hu/K/jR+YzL
 8/Ruk5n3m3+gtVQvRUs/F2C28MAgid9H2QIJogJLaUVhi6nMRSNYPPoQtkkauhfAHBjWO/QorqR
 qdO7AU0Lalp5Gsrsu4jY+wSzMVupKmbWWBcQw9m32MBXZBXlwleKPAIftMRI4vRjpSN+BQWdhRn
 y9ZHMlvP1QLa92WT4W5BVMdtZ99vDYaqWoP05/K3rAiNGt4s9j5gUYrmFWDU9UHxwFnsPZIE43r
 dTX01hSJq/yuTJqPyV+vkDxBMlOTUfudbzJCiALxJdRFLnz0eqT/GhIACMTdyPqh5f3Bz1QdQQw
 8/dWk0jfL8ozC2CzIDbYMlxtGtNqlHazBHS3Du7PfkSidgW/F99A1OEgTuhKuqSDsyEmYvYr5Pu
 EDkZDD4ramq+FMW6i/l3RjLNNFG1XWD5AMJmvZP+L9vgU9pi6+OlR+wSK6BQ+ue5wTfQ71SeIRs
 nPjZ4PaHSZXVZK/sK2w==
X-Proofpoint-ORIG-GUID: j3GUztpVg2ybURM-UrSgH90nx570rwyy
X-Proofpoint-GUID: j3GUztpVg2ybURM-UrSgH90nx570rwyy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080094

CONFIG_KUNIT is a tristate symbol but the warning suppression code in
lib/bug.c is only built if it's built-in due to it using a plain #ifdef,
rendering warning suppressions broken for kunit build as loadable module.

kunit_is_suppressed_warning() already has a stub for when kunit is
disabled so drop that guard entirely.

Suggested-by: Albert Esteve <aesteve@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 85347718ab0d ("bug/kunit: Core support for suppressing warning backtraces")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
Changes in v2:
- drop the guard entirely instead of switching to IS_ENABLED()

 lib/bug.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/bug.c b/lib/bug.c
index 292420f45811..7c1c2c27f58e 100644
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -219,14 +219,12 @@ static enum bug_trap_type __report_bug(struct bug_entry *bug, unsigned long buga
 	no_cut   = bug->flags & BUGFLAG_NO_CUT_HERE;
 	has_args = bug->flags & BUGFLAG_ARGS;
 
-#ifdef CONFIG_KUNIT
 	/*
 	 * Before the once logic so suppressed warnings do not consume
 	 * the single-fire budget of WARN_ON_ONCE().
 	 */
 	if (warning && kunit_is_suppressed_warning(true))
 		return BUG_TRAP_TYPE_WARN;
-#endif
 
 	disable_trace_on_warning();
 
-- 
2.47.3

