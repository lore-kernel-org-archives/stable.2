Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795005828;
	b=U8VERdsFyouGubh08b4lQzhnbd90F0qpM9lTSYLb530GOlf6E1UQKGAjy8eGqNLkOTcl
	 eqkA+xPKysGdOZ6qbCaTppFF88kUxVzKsDt5j1h1eaAJZFP6NOXcvteCG/VdFU8OVhZPC
	 EDQKX4ZkU9lOVv64Bb5wLjrWQXYTKtw3gPxNW+7/0jr8XeaZUks8YDcNxAP9CO5SxVPf/
	 a9aO8VO8j4EQGlpFOO00o4imSmZ2T7BPh16MPLSFN5hgeWGDRjyC15UgSF/keAOBpaS0t
	 6Nzo+56tuuDpjq1L8YamcLDB79zk1cDR+DgZG0ps+4RlVRVd18pS/fBRSxxVCWbx1lA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795005828;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=HOa9a+YmhCohrGoQIoOJu5k2eiu280ZQTpGsvtsQ4X8=;
	b=Ee3yg+8St5fLEtYo0mmL4gsQO1o8qEriegychnyitV3hp1MzuQfnlE0h60xGmczYtKXE
	 5PkajJX71LstD9mpf6rmAh0T2QC7WMCAj1I6MeEtSxQO5IjEFC+MpdwflRIRUnueYntR2
	 dNMkf/v4OM454uMGV35GjKWSJ649v7EghRi1R9ArROgIdcK9wKHxJ61GzbMnJs49cB3FC
	 ISF4IzE08q95WGI+xZu6XaZTOCAi7S+xjv3wuJIdHVRCeWlhNbysBKVV8bxbqQH0U3uj1
	 DKTXE58y2ALfhVXe5SZKLFke5hfEcjy0ts2yBQTtENCxqxYWuaulyjHemCTZba5/+eA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iAXTJNPb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB1C606A320
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 12:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACB1C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iAXTJNPb
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-498f5fa4f70so783050f8f.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 04:43:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795005826; cv=none;
        d=google.com; s=arc-20260327;
        b=PFg9kisgqroIQzq5AuxPXH+ldrAaJm61amLE5f8ioTorz1lewATb6CzKKalm8VsC1U
         xKhx9G/LEyfH41D684zdxfRVUh/As2ELaWeOwjuo0IqOjGCM4h9fgRKXqJEs+n52DRAD
         46xOBt4v8YaVNmNTcH0ayzISQv7TjvfPY4OIblblQKLNqQrauE+FJ97boVlS+UnRBKr5
         wwp1WOHVSj+lM63+6f/eWC2qiLJfGqvJFn85ualMZ7Y7+j8awvUHSwgdoVvZ8Uc5OZTT
         qEB/LgSpGqTccFbDDjXY1ffaXokkjQTS+5NBLaMJqXxaJ7Ge7pXs/T76WStJlaGiUcdB
         rK0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=HOa9a+YmhCohrGoQIoOJu5k2eiu280ZQTpGsvtsQ4X8=;
        fh=wlJLzs7lodQQLAszYoyPLt6PvNJWYyP91uYFXfmqEcU=;
        b=IcrLwAq/+vXG4vu5h/LthkhSZIPh4Y/HSfb4+2PC5j5qvzS9I/29HuQptqxC6+DCbJ
         TrpHkniV/AgzFPMss7VX5bEEAzqj5g1K2dOb0OOKzR7IgPQT8/MxJIMZJvmkVKcOrTRF
         jIHAt8kXV4Y/9hSXN1ni9HLK5oya4QD1QjkgmNS2o6uEaCmdAfQThBE5Z47ZRhoquuzy
         shYta2IIvckz7enC2osKfIjH7FWIxtSMI6gv8wI1aD2PWMBxXwcF9W70vvXJgFbJSPTp
         4Ze3X/m40Yf999pfVeAV8EOI/NSFMtMIm5AIKVL/b+YlnyxcEYuk+93ozB2Bc1Ahok8+
         ngTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795005826; x=1795610626; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HOa9a+YmhCohrGoQIoOJu5k2eiu280ZQTpGsvtsQ4X8=;
        b=iAXTJNPbbCN659b9MtFE9Nq3rMo5jF5bTb9kRrR9tpOx3pdss/rcDpa6WK1UryjALr
         ZBJAlqBA9S5KVXqKFLk59uXQ+JUt05h8tmHqKLwO6fYKzbcrvotCRgoMHWFZTWpUUGmB
         dd/cEU9vQfDFf98lUVbzKxspwMrgKoAep4AMOAUa3N/5hqJfMn6n6m24xAI9q6CbSnab
         j6k8/fztBZ5YoaPKZ2yuHtmbYUPCRlIK74ftjquzJO76AB+E3JW+utqEr99xIPLtmall
         T21cqmj8KzYzPEnD+2G7O38mgLT1PsFavjqz8D8fGobB+4KiwEN2zb9MY+grF7Bsw7xW
         E6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795005826; x=1795610626;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HOa9a+YmhCohrGoQIoOJu5k2eiu280ZQTpGsvtsQ4X8=;
        b=QCb1NBuQ/OUZGy0fCscnnOkrbx5Ip0phdhJuAyK+pKd9h46gT+YOGiN3KLeT/bAduW
         p/2EBo857lWTvy1wvWkZ2CwL9TSLbsnNqm29anaDwm2ZBfiHviOGX5wn6L19EznPvVV/
         HizNreRdptGBmBJcq/AExTLhghPNupGJRRmuC/z7Mcw/wFxFLGmrL06YPgtR+Mn0c8fz
         bVG/DTbrYfcg3VegPK+6jKxQe0fzv4UTQ6VepKYZkpTEs2hdLNWqopxWIvT2h/HkKHRw
         5pilsHxqdAy9o8ixg7QoQy5O4QMqlzLo/sGcw2eM3U4YTEXovQMKDJ/bs1GS7FnqEoyj
         XmhA==
X-Forwarded-Encrypted: i=1; AL+hErHWUxEQuH1Bg6Pi//eZr8Ju0vMJJ0Nb5NvPMe3XdPaBmbCpwYxAX0NKV/l6x0g/hmmOgauw48A=@vger.kernel.org
X-Gm-Message-State: APuU4Z9SeOwJYsl3eVaMq4MfwhbKlybn6+JUecI3de4ilauptCR81Ah0
	kZ0mOuWZQN2T3HRGUJSnt9N7MUH1muRBib9xHncG9ZNRGOPoyhRAvIO6qRd9G9TzP4rbBS1dAUD
	NZjk7RNs3WabcEF2cBfRykvxYRt66AYU=
X-Gm-Gg: AZFdTZdhMRIKoG+XagS30aEfr2q8xL8Jmk6x1JSDzR1aqM7g/wFmq1CaqR9apfsxf+E
	AkpxFgiUP1cNuiU8xcWXd9b+KMe/Izpg345GsKPTvpu0Ff2AWzMUF+VZdPltGeePRSETW7F3GiK
	roe/vPILksGwSfgiYJPy8xtJvP6CsVXr5LSQwDDpsJmzdB4tazvsKH+TazSHO7mooRurcFu6fR1
	nTqoCUnXGw/KLyx241wSOlZIKlsOKeOf88CRL/cD4fUJVl/rt6OoFqfgJ4l43UcD6mvdfhLH9i1
	QQiUd+J24X7kou5Mh37l91gjkAg+SFDtoeipQ6aw0P/Mmz8/kMCweLMslZjCXXyr53USvJpyCPu
	PctH/lugeLLnApsrwkx/NtI3TTJvzFQlVng==
X-Received: by 2002:a05:6000:4a04:b0:4a6:8012:19a with SMTP id
 ffacd0b85a97d-4a68012033bmr4116923f8f.22.1795005825888; Wed, 18 Nov 2026
 04:43:45 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Wong Steve <shyckless@gmail.com>
Date: Wed, 18 Nov 2026 20:43:33 +0800
X-Gm-Features: Aa3M54ppZITCCGdeh2x9pwMNL4N9s_TEBJJomvDgdCI7vdkibDlWPRSqczxn-uw
Message-ID: <CA+X8SdhwtAT=XoRXf_1=WBfYYrc1MWh1sywQ0uUuQ7b_b3EOeQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] coresight: etm-perf: reject events that exclude both
 kernel and user space
To: moonafterrain@outlook.com, suzuki.poulose@arm.com, mike.leach@arm.com, 
	james.clark@linaro.org, leo.yan@arm.com, alexander.shishkin@linux.intel.com, 
	mathieu.poirier@linaro.org, gregkh@linuxfoundation.org
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, danisjiang@gmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Junrui,

Nice catch, and thanks for the detailed analysis. We ran into the same
issue independently while auditing privilege checks, and I can confirm
it is real: in etm4_parse_event_config(), and in the same place in
etm3x,

        if (attr->exclude_kernel)
                curr_config->mode = ETM_MODE_EXCL_KERN;
        if (attr->exclude_user)
                curr_config->mode = ETM_MODE_EXCL_USER;

the second assignment overwrites ETM_MODE_EXCL_KERN, so an event that
sets both exclude_kernel and exclude_user excludes only user space and
still traces the kernel. perf_event_open() skips perf_allow_kernel()
when exclude_kernel is set, so the privilege check is bypassed and an
unprivileged user can trace the kernel.

Rejecting the combination in etm_event_init(), as your patch does, is
the right place to fix it and covers both etm3x and etm4x. I went
through the patch and it looks correct to me.

Reviewed-by: Suyuan Wang <stevewong@hust.edu.cn>

Suzuki, Mike, James, Leo: this still applies to next-20261117 and the
hole is still open. The patch has been out since August without a reply
-- could you let us know its status? Happy to help if anything is needed
to get it picked up.

Thanks,
Suyuan
