Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793713789;
	b=i3calxNTjm3bv5KxCJ9GUhVvwk5zfIDZWCNB3mk8pnQkyLHAQmEZwAWOUmC0PMVcDDNL
	 70vIdY4qR1LaYxHkhuZZH6eEArk2f3KRWTV5HkAvvPlY9G/E5jsFZwOWYIyDtLfMIXWDp
	 pJcZFD+fbSZxPRHr38eNsO5OsVEiamS4hDUOz/oBLsX6xWfxKJqsT4qgmJpcDHRhwQOqe
	 WfvjUikwDb5hvY9AyhVcdv0QMU96TvvSKShYppCBzsSUc8VLaCmtxXsT0HLvwTmsHbKmn
	 OxLdWKIJ6oiUOY0iuSmD21JclqgebUO+lL0nGZNKawPNdIfUlbCSO+zr8Q7sHIsL8kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793713789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NiTHky/qrLqHb3kl55Ue+tJp0FqEUYQu+BGLrGjyymA=;
	b=nkArn1NERkd/7BKxpGmC3IIx/mITiykvyhI4he2LkyIwVZRZl6oO7+sWokB8BTUhHz99
	 HabG3zukrDjQ+t0XngkCo/h69pmTjKlYnYwCkQ5nIEHlDmeGrdSnRnWWISPVTScGcar3K
	 9UtRm9Kg2CQ3px5Wiei7U1gZHQsNq4ED15ZtHD6tlXynxP3vl/GckrnL2ceR4i5GSOZK6
	 tvdKalQUy+4l6srBn5zI1tidOk9tWNgeNgKrf1pUYalf7hUHiD/Ggh3AqdOJhvl9Uby59
	 1wC22Pv8PCDWp863OcU/jn3oOcjgZfSJlRtrpRoDkVnnOOX7hwTVxJCKv9t72gc8aYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S4yaRCoY;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3E7606A328
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 13:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B3E7606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S4yaRCoY
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cd8ba7c2694so1391608a12.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 05:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793713788; x=1794318588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NiTHky/qrLqHb3kl55Ue+tJp0FqEUYQu+BGLrGjyymA=;
        b=S4yaRCoYEDIdQx9nd6MUMVyTgQ3qjcEUxTHHScdNekTUOEs49FJUebRnufc4CA0UfB
         i7VitCm15MSdNwcMNksQK0QvjqUYVkkYlVncknLcA07egs+zeTVEfXE1NtRR8C4Rmwe/
         59e38cdM5NFOiGuDV80fmbH2/2EcpFpNNYCnNsD8RlFpvSi9QEqn/BNMOG25RZbdiKzL
         nwgZBDetxUxC+AGwv/eMcJTCjKXZxosq4tRZkao88Q0YR5PIIrcjyTxKOYIp9G8Yg7Lr
         ichja6cJTKLXLq+hstuadyHfGXBIFc2bnYzaPc5K4FMhCQqDTfAe8HhC5gFbMTWcqqBO
         W3+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793713788; x=1794318588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NiTHky/qrLqHb3kl55Ue+tJp0FqEUYQu+BGLrGjyymA=;
        b=IM7bzXctDSNSpq2r4//EN7lwuIzHre3V9OXSX9Q8HZa/HG+hiwu+jQLr390MbJm6rY
         UMp7Oo7/74ZwfN/QPidOWyQc008btj/kjU0vpcdcE27ZXnGtiF7je7MwixX31a74n3Ur
         WLyzdmQZ/n+1H2PYJWpFn085Uy95ucjoCus2qZOenvljHSAf26daZdomjsCQr8mNmOhA
         /O6BK3UM2/vjW4ayZ6W7ca+BCoty4QSqA6hcaJPsTdgc88UiCbxSSQ1sJP57YdYWTiKG
         A8C+LPODLGkeG2/2hSSaHiHvdKpYu75PkKpZXfXMG25gCGpUttT/2j9jjY6hrrMtvKqv
         qstw==
X-Forwarded-Encrypted: i=1; AKwUvBwQOqZhZI7w9KM1Cj7iERijU+wib8kSoPz6AEfKQpl1vrhRffjLjD7nqOny/l0Nwy9e8NF5JP4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8f4X2ylXWTzsbYnRjdDn53agrBHF5N4cLJ54oZ4gCyVbRQccv5
	1D7U+4JN0tgeWXVNNAaag350jZIzfHCwb4wCXbedOrME5FTk57oMf/eo
X-Gm-Gg: AYBFou1s/rIeDInoJTiduNZbxx1KjbFn60dhKLqwzfL2nLNpScExy3DJTMLfojODlGX
	Kbb6oNwhXF9bDFlNbgyniTJlsEqS26qI2a48g1nyCMdwLq5TyKsluZlbVLq1YyyEzAT4KQTEQ97
	n3NZOFD8V5+IpVNWi+506Qy80r6fkTHYu7doQ48s+7+sqcrIkNyL4gBoy+uX/kDTEZelaleBgUr
	dk/TPc4koyHO/VT52TAJNi1U8LUwNz9zM9Q3PXERRjrJW66hMpTwVj2ijQLu7BQR1sGv46BCjmQ
	oYd+pLXE8y+D3pUkJ7k2zzMdg/kIhkvnqYUVbkqBflpFdQDgnUxnxcQmKQOfrWoNwesg0srS5Kf
	X3IY2q0Tpvo7BGTtTV1fABsa/v577A/9kqfyY8RGfb47pdbbh8v+GV9GTptVuYnMW8+bavthNcv
	chP4ZW8rPiZq0fWRU1IXBHsX8VO6IBb5RnHqMl4Xps8r/E6EArOgvgaTykTYiUAf9D/AjbTA/R0
	QyC0jXtmVwPyD7kmUcQXSGCiu66OGJtU/SeQB4azXNwqeZmv3t3WjitmYQTwG6RugbNyyKgxqFQ
	CzjxyBdo6hfR/R2tsP6Da2JfkBVMZvyetNULs5cmw0vqZFny8U6KseE/O0/iznh4
X-Received: by 2002:a05:6a21:b88:b0:3e1:c6e6:d101 with SMTP id adf61e73a8af0-3e928da40d0mr11428618637.29.1793713787841;
        Tue, 03 Nov 2026 05:49:47 -0800 (PST)
Received: from localhost.localdomain ([2400:d802:dd7:8000:314f:4575:be3:a064])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb36449db7sm1446391a12.8.2026.11.03.05.49.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 05:49:47 -0800 (PST)
From: Yuqiang Sun <izaiahsun@gmail.com>
To: leon@kernel.org
Cc: haris.iqbal@ionos.com,
	jinpu.wang@ionos.com,
	jgg@ziepe.ca,
	guoqing.jiang@linux.dev,
	lgs201920130244@gmail.com,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/3] RDMA/rtrs-srv: Do not free the path on path file creation failure
Date: Tue,  3 Nov 2026 21:49:39 +0800
Message-ID: <20261103134939.55513-1-izaiahsun@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261103122024.GG264423@unreal>
References: <20261103122024.GG264423@unreal>
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

On Tue, Nov 03, 2026 at 02:20:24PM +0200, Leon Romanovsky wrote:
> Interesting claim. How did you trigger the KASAN warning in the RDMA ULP?

With soft-RoCE in a KVM guest, with both ends of rtrs in the same guest,
and failslab standing in for an allocation failure:

- Kernel: rdma for-next c3e8e9451e6f, x86_64, with KASAN, RDMA_RXE,
  INFINIBAND_RTRS_CLIENT/SERVER, BLK_DEV_RNBD_CLIENT/SERVER, BLK_DEV_RAM,
  FAILSLAB and FAULT_INJECTION_STACKTRACE_FILTER, all built in.
- In the guest: "rdma link add rxe0 type rxe netdev eth0", then failslab
  is limited to call stacks through rtrs_srv_create_path_files()
  (require-start/require-end set to its range from /proc/kallsyms,
  stacktrace-depth 32, probability 100, times 1, interval N), and /dev/ram0
  is mapped through the rnbd client:
  echo "sessname=s1 path=ip:10.0.2.15 device_path=/dev/ram0" \
       > /sys/class/rnbd-client/ctl/map_device
- The server handles the client's info request in its completion worker,
  in rtrs_srv_info_req_done(). With N chosen so that the failing
  allocation is the one in kobject_init_and_add() of srv_path->kobj,
  rtrs_srv_create_path_files() fails, its kobject_put() frees srv_path
  through rtrs_srv_release(), and process_info_req() and
  rtrs_srv_info_req_done() go on using it: that is the KASAN report in
  the changelog, followed by more in rtrs_srv_close_work() and a general
  protection fault. Failing the stats kobject instead gives reports of
  the same kind.

The steps in the guest, after boot:

  ip link set eth0 up
  ip addr add 10.0.2.15/24 dev eth0
  rdma link add rxe0 type rxe netdev eth0
  f=rtrs_srv_create_path_files
  start=$(awk -v f=$f '$3 == f {print $1; exit}' /proc/kallsyms)
  end=$(sort /proc/kallsyms |
        awk -v s=$start 'found && $1 != s {print $1; exit} $1 == s {found=1}')
  F=/sys/kernel/debug/failslab
  echo 0x$start > $F/require-start
  echo 0x$end > $F/require-end
  echo 32 > $F/stacktrace-depth
  echo N > $F/task-filter
  echo N > $F/ignore-gfp-wait
  echo $N > $F/interval
  echo 1 > $F/times
  echo 2 > $F/verbose
  echo 100 > $F/probability
  echo "sessname=s1 path=ip:10.0.2.15 device_path=/dev/ram0" \
       > /sys/class/rnbd-client/ctl/map_device

With verbose=2 failslab prints the stack of the allocation it fails, so
N is found by trying N=1, 2, ... until it is the one in
kobject_init_and_add() for srv_path->kobj (21 in our build).

So it needs an allocation failure while a client connects; nothing else
is unusual. I can send the full KASAN log, the init script and the
kernel config if that helps. The client that triggers patch 2's
use-after-free from the network by sending an empty pathname (fixed by
patch 3) is not public; I can send it to you privately if you want it.

Thanks,
Yuqiang
