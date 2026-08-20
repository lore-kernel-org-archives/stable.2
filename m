Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2962939A7F6
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 21:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=148.163.152.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787262669; cv=pass; b=ApxUy5HH990SyWvOe2rIEne0qLKPNpSQaS6AFb4a5fmfpuQIs0Y/es5to+VOtgsyWwsMYmJPqeIvtmUXyiGB/9mm3CpsjwHspD9hQOsotlp2y11QgjsAgDpKxwOn2rpwcDzkrQPOoolh8Qw4YNFGNAFlb2Cq4fED0mylnpu/yUc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787262669; c=relaxed/simple;
	bh=t3iIdI23Z/Asd+i+Fpjs0YQSpaQnGxOTZsa74EYZckw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=IIef2Qe9qfhA6RWNWf5XgRQBNwdLHrb0GXC2OWLFhM37hHc3rmP62CfZqfMozaNWj81imakHqR3cehXOrA6Q5IUuqaGQCbLug/SzNJJU5Bm7DXjvuYm/qaT6ElOMpCJRA59n4VFfo3D3VRQPscVlEulmoI9kjIYeoms70Z2BGUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com; spf=pass smtp.mailfrom=crowdstrike.com; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=HkVw3Wtx; dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b=igyhJeGC; arc=pass smtp.client-ip=148.163.152.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crowdstrike.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="HkVw3Wtx";
	dkim=pass (2048-bit key) header.d=crowdstrike.com header.i=@crowdstrike.com header.b="igyhJeGC"
Received: from pps.filterd (m0354653.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KKuFrd3770530
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 21:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=cc:content-type:date:from:message-id:mime-version:subject:to;
	 s=default; bh=zVmBMwABY0b0sl+zm74njYCYQcuUz3wknze7EpIK0Sw=; b=H
	kVw3WtxV2Y538pQq//END7+SnbQV+WzqTnPfUxkOnfdv61rC39lXaK9cV/YX4jKz
	YyRQnjRZftxoZrUQY/yNGx4UK8bsLtp71WL6s3Y/dyR58jQpLwUiOxNMmOBbAkCc
	qGMa4GqFek1Byw6KGX9PI+mMqz/oqTR4KA9ty/z4kL13lgE/4CcwZ8yCBV0WNo0F
	cjABzjYf35dVzUBkQVk8g+3hpaeUoEHknokOoNLZhVi8bRct8KuhxBr8/qejNqoj
	ui7ic/2ReJcxuEtyGZ/vtuLkz2G1urHLeMA42fgmcfD1mazF8RR9T97TjllsUoE6
	49Fq8LgBV9HehkZBVDPmQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 4g62fht9y0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 21:30:53 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8ef8249f871so4435026d6.0
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 14:30:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787261453; cv=none;
        d=google.com; s=arc-20260327;
        b=HBKO4L36437YPUUB9vrcISlAxaIjJhCoNJdcO7j+IvCHj6iwdIIVRYS7HT9b6vXoxi
         GRdCTv+Z86IKoqOkQhAN7thZkXQOQxD8Jd8coeoXFh8IU3O/rPxAZ1KmAbzFYDTU4mh7
         cdsZ3jmfjGzvhYwYF8zgZar4i79Hq/OH/WZmlYxXieY6Ygh5fsNF5MVlEddQL3Tw5f5X
         c91gKlRVKTVeDqSa9sZZk2nXzD71RwxNn4s5B2qfEPfr2AmfS0Bb6ToiJCzBewh8DC9D
         44Kz3iww9QzqjIsCJh5gqvH8lcDBrz53xpYkQ0/vsocJKt0p0W6da2aKJ9RE5fJWJRq1
         0iMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=zVmBMwABY0b0sl+zm74njYCYQcuUz3wknze7EpIK0Sw=;
        fh=PVC6jltloIgHXELc8RHlCzkWy6ChK4j7ZmSovcxSI8M=;
        b=blXRUcFzF+/CwVdfwvxNV9BJCyUmMkUWHDC+Yw6rm/vLUugxHpSmkppW5xpkk7PVdq
         WKU7TBHkDVJNI3xYR5aq6m3pAzP93rHS8pA/6Swb3PncG9bpXkWogsaKY1FHtab1vN2H
         psgJB9ze1Iwy4EHnJupYWF6L9tlOD2F1ZpBZmatMQQ0VdG+D7NInc93ujDv4QJbdM7zv
         HnhBI2LBQeRwPmUjfgSsqVi9GFu6iWfbuwTXY7ijkyxobgf7okT8beuoR7XVjM3Sx2pR
         +aLn3pNHNWnNQKu+iiVGNZfsGceM2NYHQgBuZaGGzxmp3q/07oGbcU9+bIMpBt0eX230
         3oKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=crowdstrike.com; s=google; t=1787261453; x=1787866253; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zVmBMwABY0b0sl+zm74njYCYQcuUz3wknze7EpIK0Sw=;
        b=igyhJeGCYwaNQszpO5UHcZaJw6OTPx3clPZTaTCHeV8JQ34H1Atm3u6xiE9dEHFkjU
         2ZqPapNp5X/lm+XuakZszycaAqLzqmczQyZThApOh0w4law9BR1xDyDrAZZ/qp2w1Cbe
         srrVxSyMvzoKwH1GqBREeN3PDsMoXglujglx1ea3b/Rj52s0BRwa7Aoz0uS/2qcqO7qB
         y1C1xW9AgyP0g0n5JeoTVOsyWd9nQuOw3+8zBAeYrVC9J9MNQB/sy6fCvZn8TL90tks2
         zdvGq8FnYrYnzdRtRPYdSsUHGU8T/Lxx3B3qyngp3mKjxNMnCQorCgKRUfavhuF8XZ5B
         K4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787261453; x=1787866253;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zVmBMwABY0b0sl+zm74njYCYQcuUz3wknze7EpIK0Sw=;
        b=l6/p8tVjTsmXhX3l+UfvRvEqbcS7AAgqeWz3FX33WOIG6sd3oTS/vy6YCUKRpeD5I5
         hX/CGzDjJD7idHH075foD9OCPvFkSTwlsglNvbwovCBiyjyZWKENWJFDHVwkLn54Pc+o
         I+aLuJQZUAuZ5Ldbbh2C7RiTCzh6IDLafHP8Hfzl6mXrPKzPMi9C45NbOwT6Q0cS2r9L
         4MG6MzZyaV76Rls/Qmcks/2RMLtqMCuWPeiuWupHaNZ7YmFuOkWrIA4NeXI/XfotmMG+
         pOF4qEUG3vekSrGbIleQmYVvmI4xcJnbxE9Kq0gjrnCddOhbAifcZFEokWyHjCdK4wls
         JDJQ==
X-Gm-Message-State: AFuF++lJecMT9Oj0Ljty2/UBP+7g0qFCtQOxgc6WSQm3tU45P9dic31/
	IVkRf4Nmtr4DIbnUT5HzkkFo9cINMt0/7aw3646XJkJ/cuLW5I2NsOjFJvYXHS0HMRsXOuN0UXn
	YdzWjWykeWjOPFPLcUyw66zlHOkNRXtF4fjrI4ocY+jSv8v1ZPnHggdtrybQbZyuoCQogjv/U7K
	FqzaO9ei/+FtZvw9EABsQGxIVD/AtUM2NiYGjpvRXBuY8=
X-Gm-Gg: AR+sD1037S4tdv00yODJmA0X9H16B/mVOk2KHqulazHaj3eu7Piz84ioXSib5AkU3BN
	UkBWvsyRr4sZl0wQhVqlisWjj740vbBJ4ma1naiFDQ2I8sVAB++99tCBZZmM8959PTvHAu88vg8
	xNDARvriW+YSBZqegsj/Tyl64+Tvb/L76VXDPI+E8sVR9WCnoF12a5UrgA/g==
X-Received: by 2002:a05:6214:2606:b0:8fe:b7a6:4ff3 with SMTP id 6a1803df08f44-90c80c883cemr9994476d6.23.1787261452677;
        Thu, 20 Aug 2026 14:30:52 -0700 (PDT)
X-Received: by 2002:a05:6214:2606:b0:8fe:b7a6:4ff3 with SMTP id
 6a1803df08f44-90c80c883cemr9993576d6.23.1787261451963; Thu, 20 Aug 2026
 14:30:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Date: Thu, 20 Aug 2026 17:30:40 -0400
X-Gm-Features: AcwNN1WmAkz6CIfOJ3-qbyIFHw7o67a--tZpJvbx9ywHQ845dA02m4oMhEMEn_k
Message-ID: <CAOu3gNgTSWE84fgdc1iUNKwes7E6u_X6b8pjZKBULEJWB=RAqQ@mail.gmail.com>
Subject: [STABLE REQUEST] ftrace: deprecate the ftrace_enabled disable switch
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>, sashal@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        DL Linux Open Source Team <linux-open-source@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-GUID: nMjVYUmA1QeRugNwyBWIzYIXc7zbdSS8
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE2MCBTYWx0ZWRfX7QUrk/WCHOnL
 qOD5zDpaFzixZVqXkb+cEF1w0TL1RkOmgztbxym8u4XtIZI/o2vpUCWTWkv8Na9LBmpGSTR7bA0
 F8UtXK6vbitxPDbuRL0UfmHqrAsnBfkEmtqkdzy8ipo6iQpjn9IZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE2MCBTYWx0ZWRfXzv+t50TUZtQX
 5lbNh/VusMeXCn1/O6syvunrX21kXLOZj1rK8bvHgiqC4j419qGlb28NREVGdAaYKOdb/C0ggJw
 WFY/nJycNq0Cez7asfMXv2bI3DRmgLF+L35AzDBYrIHEtNse8KHyz/FQc3EAWz6RmoLjWwbJtnW
 hGdsKkUnHnG4VaeH2iNKzDj4oSh/AFFRhK2JUegzx605uZDxcwdWDaTCcbUNQMvNrAIKSwH/4+4
 xE1XnBvupWUi1M6bUwqWqi2Gg4Yrqro2JXNvDjXOwqVMez97QJu10kRlGihY3fBkonqo3bavdW5
 o1TTfiPJzcSjI9nQCcTysepIS9tgYR1fX31sEJcZWeA41rUXFQ3PXt/Xdrf57TvYolydwOYEQWS
 xKTVuHs/qY8QmIXBtg0zc39mbrc4fPLTufsW+UxpNss9Yvz5y2Pc5sS/ZGfjcfbC7njwWyo+unq
 uNRCQpYyMPA7FRVRvFg==
X-Authority-Analysis: v=2.4 cv=OrR/DS/t c=1 sm=1 tr=0 ts=6a87720d cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=KZhmPCYDdY0A:10 a=VkNPw1HP01LnGYTKEx00:22 a=T2KQ53IYiC3MXPrxx8bB:22
 a=GCXdLZfFv8EKBZhKOxZ5:22 a=VwQbUJbxAAAA:8 a=pl6vuDidAAAA:8
 a=YqAk_y5rjQpCD7sbxlsA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: nMjVYUmA1QeRugNwyBWIzYIXc7zbdSS8
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11881
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200160

Hello stable team,

Please consider backporting the following two commits to the stable trees:

  - b0c857049153680e1b6ccb59abf359a4ca523561 ("ftrace: deprecate
disabling via ftrace_enabled sysctl")
  - 88b3e7fedc07d940c32eb5c0733a780e944b6b47 ("selftests/livepatch:
update test-ftrace.sh for deprecated ftrace_enabled")

Both commits were merged into mainline in v7.3 via the 'ftrace-v7.3' tag.

This change addresses a long-standing issue: setting
kernel.ftrace_enabled=0 silently disables BPF trampolines
(fentry/fexit) and ftrace-based kprobes/kretprobes. The write succeeds
and the hooks stop firing without error, while re-enabling silently
restores them. Livepatch resolved this via FTRACE_OPS_FL_PERMANENT,
which blocks disabling ftrace while a permanent ops is registered and
blocks registration while ftrace is disabled. Trampolines had this
same protection from 2019 to 2022 while sharing a global direct_ops
marked permanent, but lost it during the 2022 per-trampoline-ops
split. ftrace based Kprobes never had this protection.

The breakage was introduced in commit 00963a2e75a8 ("bpf: Support
bpf_trampoline on functions with IPMODIFY (e.g. livepatch)").

With these commits, writing 0 is refused with -EOPNOTSUPP and a
one-time warning is logged; reads and writing 1 are unaffected. Steven
Rostedt requested and reviewed this change on the mailing list,
including the follow-up selftest update.

We would like to backport this to LTS branches starting with 6.1.y,
where the breaking commit already exists.

Mailing list threads for reference:

  - RFC v1: https://lore.kernel.org/bpf/20260730163544.2042327-1-andrey.grodzovsky@crowdstrike.com/
  - RFC v3 (final):
https://lore.kernel.org/bpf/20260806153000.4184871-1-andrey.grodzovsky@crowdstrike.com/

I can provide rebased backports for any trees where these commits do
not apply cleanly.

Thanks,
Andrey Grodzovsky
