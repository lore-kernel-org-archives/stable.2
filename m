Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3108F44B68B;
	Mon, 28 Sep 2026 06:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790578289; cv=none; b=Ou1qBdWYIeaCuCBP55h3tS4LajB/1lzrSA4Nv57ZJQKo2qc7AsBGtMrqoZs3VOHRs00EGqHYNjVdjh8AsIxfzUjjm2WcdLvukoquQfvtifnOWqqWGepM55TsipvQqJkKqKQaC51Tu2QZF4s6t54532e30SVZjj6TgS6j5I5xZ/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790578289; c=relaxed/simple;
	bh=g30+Ouih9hKzNp23bdeOAgIPVF6MR4hbNeyi4JjJ6CA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G6eHYbyKY2Z7265g2tiIYTWHVWNBcXnSxGsjhwec01xlEtdfn6Dh6JCtukcjf8YjdyCkBr1nfhOzKtN8TNrqZaF6w2m4r/8F2/GFYfQFThOMr2V+k0J6oCHbwSJQIQT2V4jb17ZhToT1B7FpjYJ8w0k9bxL9qIJJxnPW8+dwlME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MyG8QFDg; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MyG8QFDg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Oq
	BaAnE2oIaQa/7VXfJCai6gvSX8hbezKNuMG55IdGI=; b=MyG8QFDgbNIlOnmhDH
	HkQwPziF2tsFV8yE9SFl3bpR+tSZ/BbVnVDK+toqNQzHNsbeW07KT/9xdBp7iw8U
	rZxqTmvdDXk9AsGnVvp3EYkjFHjAO+5rfYjZ3BfoqiTDgveCDQ270fUpOKQBGcxm
	YHVSYbb/h1WpL+/t4l3CL1Mrc=
Received: from chaosheng-ASUS-TUF-Gaming-F16-FX607JV-FX607JV.lan (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD338lcDrpqNj3_BA--.62282S4;
	Mon, 28 Sep 2026 14:51:10 +0800 (CST)
From: Quchaosheng <quchaosheng000406@163.com>
To: zjamg <ndaugoing@gmail.com>
Cc: Quchaosheng <quchaosheng000406@163.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] can: restore skb header initialisations in init_can_skb()
Date: Mon, 28 Sep 2026 14:50:53 +0800
Message-ID: <20260928065053.1750765-3-quchaosheng000406@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917123716.63116-1-ndaugoing@gmail.com>
References: <20260928065053.1750765-1-quchaosheng000406@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD338lcDrpqNj3_BA--.62282S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar1kKr1rtF18AF4fJr4ruFg_yoW8Ww4Up3
	9xK3Z8Ar4DZFy3C3yIgF1jqa4Fyrs8ta4UuayDGr4UZ3WYgryxAFWIgry5ur909rs5G34a
	yFyDZw1Ska1DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRx-BtUUUUU=
X-CM-SenderInfo: xtxfxtprvkv0bjqqikiqw6il2tof0z/xtbC-x7jWWq6Dl579AAA3U

Hello zjamg,

I reproduced the panic independently and verified that your patch alone
fixes it, so:

Tested-by: Quchaosheng <quchaosheng000406@163.com>

How I tested, in case it is useful for the maintainers.  The driver RX
path is required: vcan does not reproduce it, because can_send() resets
the headers itself on the way out.  I used slcan over a pty, opened a
SOCK_PACKET socket on the resulting can0, and pushed one frame in through
the line discipline.  Two kernels, same config, same initramfs, only your
patch differing.

Without the patch, v7.3.0-rc5 under QEMU:

  skbuff: skb_under_panic: text:ffffffffa0b28261 len:-65455 put:-65471 head:... data:... tail:0x50 end:0x180 dev:can0
  kernel BUG at net/core/skbuff.c:214!
  RIP: 0010:skb_panic+0x50/0x60
  Call Trace:
   <TASK>
   skb_push+0x4d/0x60
   packet_rcv_spkt+0xe1/0x170
  Kernel panic - not syncing: Fatal exception in interrupt

  (the len/put values match the ones in your report)

With your v2 applied verbatim, the identical run prints

  RESULT: survived, no skb_under_panic

and the guest powers off normally.

One note that may be worth adding to the commit message if you respin: the
2015 fix you reference, 969439016d2c, is the second time this class of bug
was closed on the producer side.  packet_rcv_spkt() has still never been
hardened, which is why the same failure mode came back a third time when
9f10374bb024 dropped the calls again.  I sent a separate patch for that
receiver-side guard so the next regression of this kind degrades to a
dropped frame instead of a panic - no overlap with this one, and yours is
the one that fixes the actual regression.

Thanks for picking this up,
Quchaosheng

