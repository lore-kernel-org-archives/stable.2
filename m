Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6EE42DA3D
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 08:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788424523; cv=none; b=dJPIG/iNzXwr5dwfbBCb9H1fFo5qYPY4l6urWeZ+fm+FsmQVGUFMysyudcphxNWGjFbDvtDj1la7gTeyLp6uGBTz2kjJXZaKiXkb63++IrNV6kainHicKogoBwUq0G2ZdvBzhrYPI0091c3lwY6bWMWxHPrK5ScKkVR1ULyzdVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788424523; c=relaxed/simple;
	bh=/al7R5lGyABC5BAdv2q6KsiylkPVrrOvcHfyvOD6jio=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JratKkaJg309zSTwEByTzy95ofi+mCyRbBdUUMkDv6diycvQERIUxK3wRfv6CqDlJzLOdCxvHxSQLIhkF054MkEp+Z4kX0F2xn+/wU4TqDBkb578WBG5zrLY6t1/8Tre65B0eCw7WQ98kY9N5C4QIvJg4SJ1rSPsK9N+S0ZF4wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pUIiKenQ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUIiKenQ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-499ac87c92bso20851655e9.1
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 01:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788424520; x=1789029320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xk9CG0h6HWfqzzpvcIHPsx0W6k1L3yQKeOEbT++aQsw=;
        b=pUIiKenQG1U+GVK5KR1bp0PB/OI2VQDbQ49VUHqP658yAGp9PlHO1T0yfQXrDkl5cB
         QKBWDxwBHowxaNINq3EtPx/2pq8RAcsux7tiIJTzJGT///9/mzcGDse2kk3rO4fsWw2m
         uln7yZIePBi5II9XdRYtZg9mkkoFwwpP9dGH2vhYOke6L6ssxwy3a3t/XvvgTYl/fplT
         /ZIwgaT40rkAw7wIaEI2O9rZz7SfnNhR3n8VV4SfrgDeTmDOQjHjO5/sy0p4KBbsNMhE
         pejbB61P7EFOBtjDe3dHaBtoQs7p3JFtbUgML3qPeOQiooEndUBfUJlwzIkgpq90SYig
         RiPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788424520; x=1789029320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xk9CG0h6HWfqzzpvcIHPsx0W6k1L3yQKeOEbT++aQsw=;
        b=THPX7IvReLhWT3BiFP+9vzrJV58QcE6fFHjsh9ibGCYXBgGLBwMbWhlx27eCVMVhaq
         zxfAZkA5qoVe3YuvX4/gmMT+Mgf7yCs6Qh3mYnWYzX+AOh1uHVQKWEOUQGVmMQr3KvKs
         szkretv07WUdDhbZg3mDM8HBSfIcoFEGf5uhgmEDcLtq8eeY6dkSQ5sCbpdCcXjw5Pwh
         uJ2CFfATy9nzZ7hincBtF3E6JAdZgj8lOuzhClW69Au9FZPVlq8g1ZrgUg9Xyw9OBvDj
         MnvM4nwvjYrx5HHAqLBGvl1UwdU+WMbk2d0nrCbheNwa3vRSS5zMsdGh7wAvlh0y5MKL
         NmiQ==
X-Gm-Message-State: AFuF++lN8XsFhjbtuNLkCp0yQnuA8kcboGeSRbSY2fJG6e1jS1GoGN6a
	lYB412a2qJdatXKsUbA0nMn7uIAsgoxdjJIIU36W8nbmDKnSWvHTs7Bkm5zVkj4O
X-Gm-Gg: AYBFou3PEz2wCvW01mWVbsF7TeRrrdpBgX+hYzotFCu4LQ+gHGorZhCPgRWkesR8rDi
	Gjt0yIvVNNguQ6D6SQXmha98U5+69pUb+a1IZ4ieDKu7/of2934lZgg+FhJ9ZMs9XS4bmSj7o9S
	WkRGuBT1gcGbASvYB7DpzaOqPYrrPn5c8uohKLus7Xv7WUueh1xaf8pzFaBbGdk9noRrrDtX3mt
	EJ6HWygG1RImGVUip93ZOFlbgHxuUWZnLxkonR5ALKby0jc5f+pKOwmbc5yKJ56qrqqPkZCGUbO
	pezeoH1AlhX49pAsPKg0D0LxG5vna8La1GL3wc31gs7x7GuIp5olzjtLtBIjN3B6f+AS6hcoULq
	WFA4n1FfuDWSChWLLP8/fOFXRUsw4TTyeaMePf3dhui3N0ckwv+dg9Jr24Udo3xfgkT2/MyDRVp
	/7SD0YHkfwNO1EeL6Rq8P1P22qgf8Xe13fx+8MhfRT2k0Cf16ctYczAZycEKru2PQmxkS0WDTm8
	yvCexjxzzlRCUAHjD2XdnvpYLKaqjgBXBrovFwvjdu+Qc/n9b6yqFFgAlCK1eW2W993EXcDlUk0
	swwALBSiVIGXGkXmvxGqbVSUC++HMqvj9tbjFovIVuDPtfdRvLVIZt0zYjClO4BmEEIM/xTGdAr
	dWDci
X-Received: by 2002:a05:600c:8b10:b0:49b:12c2:104f with SMTP id 5b1f17b1804b1-49ce55ecddamr220293825e9.1.1788424519871;
        Thu, 03 Sep 2026 01:35:19 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a979-9501-3df6-d7fa-8a5a-06c5.310.pool.telefonica.de. [2a02:3100:a979:9501:3df6:d7fa:8a5a:6c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce58da3acsm228357425e9.0.2026.09.03.01.35.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 03 Sep 2026 01:35:19 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: stable@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5.10.y 0/2] mptcp: fix ADD_ADDR retransmission socket leaks
Date: Thu,  3 Sep 2026 10:35:10 +0200
Message-Id: <20260903083512.99864-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Backport the two ordered ADD_ADDR retransmission timer fixes missing from
5.10.y. Patch 1 makes every terminal path release the socket reference
held by the timer. Patch 2 uses sock_put() so the last reference frees the
socket, while avoiding a timer self-deadlock during destruction.

Both fixes carry Cc: stable and are present in 5.15.y and every newer
supported LTS. The original 11-patch cover groups patches 3-5 as the
v5.10 ADD_ADDR timer data-race and leak fixes. Patch 3 is already present
as d9b272a85fe6 ("mptcp: pm: ADD_ADDR rtx: fix potential data-race");
this series supplies the missing ordered patches 4 and 5:
https://patch.msgid.link/20260505-net-mptcp-pm-fixes-7-1-rc3-v1-0-fca8091060a4@kernel.org

In v5.10 the timer code is in pm_netlink.c and uses fixed retransmission
delays; the adaptations retain those details. Patch 1 also routes v5.10's
unreachable ID 0 guard through the reference drop.

Tested on v5.10.269 with KASAN under QEMU. A targeted A/B forced the
tracked MPTCP socket to TCP_CLOSE at timer entry: the vulnerable kernel
ran the callback without destroying the socket, while the fixed kernel
destroyed it. Both completed an identical MPTCP transfer without a KASAN
report, Oops, or warning.

The fixed kernel also passed all 15 tests in pm_netlink.sh, a 16 MiB
bidirectional transfer with a real ADD_ADDR/MP_JOIN second subflow, and an
8 MiB curl --mptcp transfer. All payload comparisons were byte-exact.

Matthieu Baerts (NGI0) (2):
  mptcp: pm: ADD_ADDR rtx: always decrease sk refcount
  mptcp: pm: ADD_ADDR rtx: free sk if last

 net/mptcp/pm_netlink.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

-- 
2.53.0
