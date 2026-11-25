Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618761;
	b=FF7bAoIboYED1nrWWd4Eyt7Tt7K+p1IBZKvJJYNV6c0ql6ge4h/1SsS6QKrLrw+Xi6Kq
	 jtISutO1ZF+Gmk55CNRwXgw+sIMQSoLTywRDI7tFTYZog5hsF7zJf9TBLdMlLnezp9QW6
	 iBobq7930TaudnVyDRoa9XuV1cqgb+bWfMp4N1N9GSE1kScMgv/b8CvTN5oG09czgQ2iz
	 DW6kLuvZE8wb/rLu+C8vvObeWExozYjr+MBd2oD5LP2LOdSsFUVUQPxRtYWUKWVp5WUDU
	 cM8GJpJtCBQYlSLSaMRiuhC3QFqeuNl43vrQeBkS3UVUeimt23au2/q0+0MceWxViag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618761;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:Subject:From:To:Cc:Reply-To:
	 Date:Message-ID;
	bh=EaPQTnYe0VFsuxqXpwALRiNijGC8Fn+1gqmC4FS2Hig=;
	b=Zu/nieFJ3zDTiFteDbVGb6vSsmL/c5fOoOAx3ZfFKqVaNVV7N9M4EyNcDAmSoyJlcpQ8
	 0RfBttuzZ/dVP75Kn5jDAUu8AhxV+Wm4ZjasbhV6zLwrLU86NSE83JYqL+9HVPf8tYDjR
	 3aBLwFvg2XfaL/ELX+QvXT4uyzvOOipXQ6pHa69kE64psLbb3QVCXJ3zpXXekcJrM9tIo
	 bIB1XqW0CUeIK60obJvvvFx3z71MdyUvMcEO5SsAEuHt6ObmlpWaZx1rq+SJdSxsVIrEf
	 nVOdijxfJvGL/9l4qg5kXvN1sFPFfpJFVRl8pnhbVDxoswvzSrjglFYEGSyjCb8nvrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernelci.org;
	spf=pass smtp.mailfrom=kernelci.org;
	dkim=pass header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=Xgd+JqjQ;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6409B606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:59:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6409B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.a=rsa-sha256 header.s=google header.b=Xgd+JqjQ
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-38699cf08dfso6945232eec.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 06:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1795618760; x=1796223560; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EaPQTnYe0VFsuxqXpwALRiNijGC8Fn+1gqmC4FS2Hig=;
        b=Xgd+JqjQJPoUzeIK4154je1UPjh+AbLaNyfYEKhkahNZilqCSejYqc8IW4PX7RihD0
         RqZVKAHiZNHSj2ZrXgu9SfaEO3u9uC76iRC9CTaoas8vbEQSjlrXNmLGOFcESch8F+Kh
         41qcO8wArwSXvItd4oGH0kaOnX9fcOmtiXZfX50JxSd36ogNIKX4mSclnU5p7AHQMmXR
         sbFLU/69q4jlqBOEhe/onQORAUD6YyOgbbkFABdKVMq3zsJfVZ8suwLpEUrrwUd6W/Vf
         HW2rrhQjeS65DD/238SiMSOq36GZIhjVeWZ4datEVU6SnUXR4ciItjGvIhJmK7SBgWkS
         cTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795618760; x=1796223560;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EaPQTnYe0VFsuxqXpwALRiNijGC8Fn+1gqmC4FS2Hig=;
        b=Wi0ctv14MD5OjjiiOhnciLhty/aMTvfJou3x6m74Sd1Fb60Gt8EcpKdKf/8S4NBwka
         Uaal+Pr6/0zKsmQQNmNyJOEpS9xTDICVuEYfCdfnJDHg1kTvo10noILAzQ5AOdejAK8a
         R5TXKRz00RMcODfCWQN8bODpbS+XNFnrv5ax2dQI4qFhQgrjVWGq5P1xLgmSgmGAMxPM
         3pHzA98rYjeyBrykhs637v7crj6OS5ImFvKJjrgAdeA05i3cSj4GDFIQ8irDrwhxYZNf
         GjUrrZCh8ciWAusKr7OT+mFQIumBC3hyu8C7b2JJ2RU/P4/4tzCzMNya4gtS+l//liwc
         fhiA==
X-Gm-Message-State: APuU4Z/IjyMGPM8PWOSiVclhStrqBVClAUSUKfTQu37V9f718PgVDVff
	E8e0pc3XUBPlRq/1AeEwuEKQZDp73Em2cD2h2acwcyIkNZXoX9jeVwyzX0l0EL/7kIK7l7jeD5Y
	+uwuH
X-Gm-Gg: AZFdTZdA3jxQ1+ZvezRWh8p+O9dYGRNOxylF0qYUTqEExiiQAuq76cb+s5COWfkSX8P
	dUtJJJiwEJS8ZwjouHxPC8oCtGouxh4r98U8VSMGXS8fEo8JIRRZpTmBog46iCx+q3qPYDhJ34G
	N8ORp9ASWwi3Xi5EBI+8h7ro0DAPog6GAIi6ox0F9rOe9FvDccHbfzb14MMdJG2jQ9TYBrjwHbB
	BCr/dcaqqjK+Jm4TElB/AORp4TVLornexVvv8vv1sqZx00yXUaNCaJHPZ5AApgbtHB/49fkUmhd
	rxXV+S6SE986O6YnUCy1xm2Mu70bTwARnvyWGWETh06ouN431pn3c7jgyXA7Z/vlBpmRwV8vw7F
	LSJOFs9GUbTCQbrbldw6SHsfFXB8AotkwAmQHs+AhqemWBgrrwDd15bHZs7UiWxRMw9YSr4mrSG
	4oH+qJqgR8cqXl6/zNI45/8io1zgPR/GiDtaDCvHUtqj1SjjZz4TBnIce35liLjCHHNrvhGPZbI
	um+n/pR1edg/LQ5XSd55X3At8ZJG3ML5aNfA+gUTdecT1ysaMNzy4gBw90JmAwwFK2PkuI7BlFz
	WfWG9pwb/ghJuDcGJ1MwaQ==
X-Received: by 2002:a05:7301:db86:b0:36e:2b8b:a098 with SMTP id 5a478bee46e88-3857025c736mr17432314eec.31.1795618760443;
        Wed, 25 Nov 2026 06:59:20 -0800 (PST)
Received: from 52d83ede7c60 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e96bdsm51467168eec.7.2026.11.25.06.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:59:19 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
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
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-6=2E1=2Ey=3A_=28build=29variable_?=
 =?utf-8?q?=E2=80=98cbnl=E2=80=99_has_initializer_but_incomplete_type_in_fs/?=
 =?utf-8?q?nfs/nfs4p=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 25 Nov 2026 14:59:19 -0000
Message-ID: <179561875895.101431.15176462398075874766@kernelci.org>

Cc from: regression/stable-rc.yaml

New build issue found on stable-rc/linux-6.1.y:

---
variable ‘cbnl’ has initializer but incomplete type in fs/nfs/nfs4proc.o (fs/nfs/nfs4proc.c) [logspec:kbuild,kbuild.compiler.error]
---

Log excerpt:
=====================================================
fs/nfs/nfs4proc.c:7113:24: error: variable ‘cbnl’ has initializer but incomplete type
 7113 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                        ^~~~~~~~~~~~~~~~~~~
fs/nfs/nfs4proc.c:7113:54: error: ‘struct cb_notify_lock_args’ has no member named ‘cbnl_valid’
 7113 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                                                      ^~~~~~~~~~
fs/nfs/nfs4proc.c:7113:67: error: excess elements in struct initializer [-Werror]
 7113 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                                                                   ^~~~~
fs/nfs/nfs4proc.c:7113:67: note: (near initialization for ‘cbnl’)
fs/nfs/nfs4proc.c:7113:44: error: storage size of ‘cbnl’ isn’t known
 7113 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                                            ^~~~
  AR      drivers/dma/hsu/built-in.a
fs/nfs/nfs4proc.c:7117:33: error: ‘struct nfs_client’ has no member named ‘cl_lock_waitq’; did you mean ‘cl_rpcwaitq’?
 7117 |                 __wake_up(&clp->cl_lock_waitq, TASK_NORMAL, 0, &cbnl);
      |                                 ^~~~~~~~~~~~~
      |                                 cl_rpcwaitq
fs/nfs/nfs4proc.c:7113:44: error: unused variable ‘cbnl’ [-Werror=unused-variable]
 7113 |                 struct cb_notify_lock_args cbnl = { .cbnl_valid = false };
      |                                            ^~~~
  AR      drivers/dma/idxd/built-in.a
  CC      drivers/dma/dw/dw.o
  AR      drivers/dma/mediatek/built-in.a
  AR      drivers/dma/qcom/built-in.a
  CC      drivers/dma/dw/idma32.o
  CC      arch/x86/pci/early.o
cc1: all warnings being treated as errors

=====================================================

When fixing this issue, please attribute this report according to the
patch submission rules:

Reported-by: kernelci.org bot <bot@kernelci.org>

For complete logs and details about the environment used, see the issue
on the KernelCI dashboard:

- dashboard: https://d.kernelci.org/i/maestro:50dce87c26fc4ce16821e62f44c7b91c8ea2bba4
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  1c9c007d0246db7a5d04105e86069fe5ba06e01a

# Builds where the incident occurred:

## i386_defconfig on (i386):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-i386-6b06f032286e1965ecb36495/.config
- dashboard: https://d.kernelci.org/build/maestro:6b06f032286e1965ecb36495

## i386_defconfig+kselftest on (i386):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-i386-kselftest-6b06f043286e1965ecb36549/.config
- dashboard: https://d.kernelci.org/build/maestro:6b06f043286e1965ecb36549

## x86_64_defconfig+lab-setup+x86-board+kselftest on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:6b06f05d286e1965ecb36602

#kernelci issue maestro:50dce87c26fc4ce16821e62f44c7b91c8ea2bba4

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
