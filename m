Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF8F37AA95
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 08:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789980110; cv=none; b=IS46WWQS9Sc5MDvryZcWDG3aQd8U8uEV/I5JeFqvdSg9ZvJIv1CR9P9jUUFcL6n3fEhm3NEIF1kySK2XbzOKon28WYGkkCPDyWRYYGyTsrLBPqfXKBt6GkqVYqcBsR7I/6P5HzroUdN3TL4cuHpu7i3YZ0uNqC2cpz9nWZDT/5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789980110; c=relaxed/simple;
	bh=V3z8Q6QM1+WIqVVJT9vQ/tq1lzesanx0RdBKGHqMMbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZZ08i6hvnFlp/M7fmFhhQe5XmVwcSdvhTnhi/j7CttVLoNTCO9oSzc+zvZ4ckA8F/w5F87pPkB+Hrk03jLYEzq34NORHx1k1isDO2PTXTg/57aVCwwky+OiEfQSkP5Z5dSnJ2ng8uPyhMBroK5S6nZBUVxB59QqCttVyE8xP9ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MKTI3DfR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P+g3mPQR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MKTI3DfR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P+g3mPQR"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68L7A0LH607146
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 08:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k6ShR4rnHoHnEXINqW+ybyNwN+9yX7I48PaAhsMmBM8=; b=MKTI3DfRTnrbkXS8
	DC5LyWbpVjMR5pijpL59QVo1Kqh7nRIYxJweXPtHjPuKhTDIaMAzbFaYArH2TFLa
	J8GYEuhR1D50eDS5Mklrb15lNiwQ6L9r4k9BdAQzitu28bkt5gljVYPAmwlgDVrU
	4Eg/+ud/CRkJ8Cvsf+CebnPOe11QvSJ6wpq4Z8g3Kapuvef3/ZAyAovRc6MAyJT2
	OUerinnA0a/K4C7yno4dhkjiyEfRer9RfxsB0SbaE7wVfxUQvfIdfP8y/J3hqpcd
	g+NUbbO5a3f2e3xOUT5sQA+20E/Howt0PD0+Bng8u7udBRDYq7KddElxqvZ4JZaB
	DwVYtg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gtu1ehcgw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 08:41:48 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-939f925ba4eso381396885a.3
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 01:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789980107; x=1790584907; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k6ShR4rnHoHnEXINqW+ybyNwN+9yX7I48PaAhsMmBM8=;
        b=P+g3mPQRB0ELTuAwR/8tNInXEuZnKNmsgPxQlJAI+9drtFyQ/m96LJ9mi9fdQ15njD
         KZQ5LSzsl85DUZ3oEJY2o9K0w+CfLuNGTbq1p54QvhOAPah99Be6tqWhVFgi4zB8j3Db
         oI7NHy5OHM7P+ZDb1qLBv/Jxm3d0/aI5hnHM0FWJ2xw71510m6gK8zMDE9f1ZkkXU8Yc
         0lj9QfdYFJZ0dyBsZk0RL1v5Mom1mvUYcOkfZ+gJysokKTwVl6LzyiR4FSG/mlSVaGmT
         ydh6nzPNKYK271nBCf/KUZ51G7pi9jItWFsXRkZubDPnb+Y6Q736cg+A0SKV7yhhS9sc
         3KMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789980107; x=1790584907;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k6ShR4rnHoHnEXINqW+ybyNwN+9yX7I48PaAhsMmBM8=;
        b=yoFszEbe6QKhLRnRcu8uupB7FzHAdNpnuKmtQYn1mVKVK3rhxWbCgfvFeejm3lsJ4X
         D4qy9uW6dUlX2hg8oXRAWwPJ/i0nboB4tNbMNUmP0/6LBRnDJkoIVE8ib4LA59Xiw347
         YY8WM7k++hjxdgDyy1Xnc5Hd0QBOFS3Wdcl3kcxMzOzgzeYN053SDDJAMv1WdPMdb385
         1sYkfDxFGl+PI12KclwV6bcUY/r4PN6CwyiS5I/eAMdz13ALHu2blegwQWw5IN8dJ93B
         8oK2uWxgjoYIWBRQRCbDK0U7NXVk8/nt+hyzxVJRs001Y2WNTivpuXgh0vxtHxJBa+Ct
         zCbQ==
X-Forwarded-Encrypted: i=1; AKwUvBxVpCfmGR12XhxV99wCwmluoW4fLorJsWdDZMI/YXhcMgr2y/IUcR0uxak/YKjdqziMEbQFDas=@vger.kernel.org
X-Gm-Message-State: AFuF++nWTV/KijPMMdL4lJeTVg+3mAe69+81B/mBUpxd2LheSuC3cH1g
	FiZKTSt/hj8hT7zd338Q70dUGIABjUheTen7g+4hlYMiaKVvGNE2PL1GUHV+VKWPk4WTxteVQET
	UMLoezdPDZ/2LEFhW6bvNmkst6/n3PCHSQtTrU6FONhfnaiQF7BGACE+fs32jiWzQnoI=
X-Gm-Gg: AYBFou1fz/0DfgqKdc1yc5rPqNEtDttxuecMLEWZfbBXy6FTIF9rXCowr3UfZI7g9wt
	UoRuo1ZxKb5WhSaEHyb70gz4phZrF1aP64FIGrBUV7wt45btpjl63TMw1ESq3luET9kacow7mTf
	9ocyTOCD8GQSUdLo5gPQ5UrXHJGDOlpcWmdiL89YWrbaBfAjwy8ZdUbcWJipoTWsHRq/Z5C3DJD
	KOreEM7fyQqRfhA57/+oAXfF77trb9JtP9M1EO6jIUtos689gGufDfTGKtbvMMAXY7PlUm4oEn4
	aQAeSFYi2Kp8OikICIxgM3MgGu2NUDIGmdGr2cWRA0zOh6pQCYynrZ6zAZYAD3FatjBMmL8Gvz5
	F3MEand/EDPmdxJrAuKcuxz7+RA==
X-Received: by 2002:a05:620a:8808:b0:939:13bf:e861 with SMTP id af79cd13be357-93bf56efb11mr869352585a.40.1789980107632;
        Mon, 21 Sep 2026 01:41:47 -0700 (PDT)
X-Received: by 2002:a05:620a:8808:b0:939:13bf:e861 with SMTP id af79cd13be357-93bf56efb11mr869349785a.40.1789980107158;
        Mon, 21 Sep 2026 01:41:47 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:d04:d483:faad:1e4e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4872456325esm21220967f8f.15.2026.09.21.01.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 01:41:44 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, sashiko-bot <sashiko-bot@kernel.org>
Subject: Re: (subset) [PATCH v2 0/4] power: sequencing: add kunit test cases
Date: Mon, 21 Sep 2026 10:41:41 +0200
Message-ID: <178998009681.23332.10018072172593243626.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260909-pwrseq-kunit-v2-0-ef496afc89d2@oss.qualcomm.com>
References: <20260909-pwrseq-kunit-v2-0-ef496afc89d2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDEyNCBTYWx0ZWRfX5JmTKNzyOnLo
 YvKNYrwzF7hR+Awgcgy04Fldq4zxLTlVl5B5z7/mmt03G1im6Cw3GsM5OU7PBv/F4Qo0yBhttzl
 cUmAHxJv09EBI/cVT4HXxrT3AYwT3jU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDEyNCBTYWx0ZWRfX9s2+76iMEeC6
 pnmHH8f6AOTTjfo7GJS/3QSDkCZvpU2h3mP8YMxKTsGVyNQ7i/BQZ1akuIM/iUmVlCQG8kOs5yw
 6Nv2jny3ioYqYNNHYHSO5TtC8j55D2zId1Yw5XiYTBppX0SJAGIVh0eACMkY1wKf+HBUKYGz3i9
 9NqrMwbBmqfkt9uggA74yiTeE0pH1XCvVlWNn8mz//3AsKKQykafGhIHiAr/nN+6za/Uu0H2gBO
 JlNtt4B0lFFYcLeht6n83DhSuhfI6gomgEeMuE2d7FcDe344WOYPpoGD1100IHKcQY37s7fpZj3
 5Qrf8LhpaKr1NX5Mr1vs3pYOkXcLFwKueHlXlIJpuSZmUxndJCpvekMjLKWZnywhn3seipvdckj
 rX//13A18qGbUnxyGte9JXGjDSkO0ZWdG5BP+gozHEXMO1Ux6kq+NBuf2WNA/yPGn13OHMNkokL
 zSiPJ+yjOjjBrC0g8qA==
X-Proofpoint-ORIG-GUID: aeNqCrxYE_-KawACQvHhZWsZwHBT5n6p
X-Proofpoint-GUID: aeNqCrxYE_-KawACQvHhZWsZwHBT5n6p
X-Authority-Analysis: v=2.4 cv=A6r5rKWG c=1 sm=1 tr=0 ts=6ab0edcc cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=6CFNrt-8cbJvt-LAfKoA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210124


On Wed, 09 Sep 2026 14:37:06 +0200, Bartosz Golaszewski wrote:
> Add a set of kunit test cases for the power sequencing subsystem. Also
> fix issues noticed when writing the tests.
> 
> 

Applied, thanks!

[4/4] power: sequencing: add kunit test cases
      https://git.kernel.org/brgl/c/c42e50314a7629ada42a605666b18e22867a6b44

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
