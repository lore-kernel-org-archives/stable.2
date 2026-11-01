Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793537828;
	b=Ji9G50iJcBkQb5D7sCHsEckItBnM1QgFae+DZ5lw3cMYENpbgSRfCW7glJyT/tuQNtF6
	 5qMmEveFsaw28lWTopfCMaDSwDRkGwDoGRfwrv3WA83IU1sGfaCFI79ly1j5j6ZnTq0Ix
	 mRXSWM2DBAqRwdulixsTuH3LyqXbTZZPC1BS0rS5qP0pTu4b3x9VpHMd5KScNv6V/EE+8
	 wkT2FeQliUvnykv9FiQ+ECsXed2+wMirf/OuBu64O+a091bbUthy1kN60cT92jZ1K41z4
	 9cMo5MQi1Fx6EXaVmznkZILNBD8qn6J17zZ6awUDzYUVKuimDTFB3hXGMaK41qMqCGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793537828;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=d+gck0iAz0g9YmtuVzk/9wF3YHbUVQyIawc2KxMLISw=;
	b=PxWB2gzVbqGhEUDrGBEgC9uS52wYvembnua5HvYhrPaE8rJg297AhBUbD4DyTGqHT/aT
	 AtcGoXcJitIWd56hLMV1RWSEBMOQqO4d4Ru19zeowMidPdiEfJGqT8yWxgn3N6XaBOLjM
	 YkY6+PlKNZc5E/0y9Fj7QVqP7ERRtppYR4VI0TZBK2dotdKjd9QlQe96gBJMab5A0Vwg1
	 94Zub4riaLSTsHFnfLf/PrI6bcBhdQeZfLzAFdR/dCS1elmf+j4iIQPYxqMb8nLf6+fN5
	 05VyAAdQqgDA2wu1e3ZhlVWow1gaKpTx+FYaECwhO60zDZXo50KVTxdMWF4E8ZqlwVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Rrzxo15l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469F6606A324;
	Sun,  1 Nov 2026 12:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Rrzxo15l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907531F000C1;
	Sun,  1 Nov 2026 12:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793537827;
	bh=d+gck0iAz0g9YmtuVzk/9wF3YHbUVQyIawc2KxMLISw=;
	h=From:To:Cc:Subject:Date;
	b=Rrzxo15lHNtSDnV4DrQPOx4hrQ+ZVkpxS2lbCezzUp9Yn8kXpR6es5lb/IDn1rQLS
	 tx4EftJ0Am+KcuQ0CDYlYkZV0rs1n6kz6WTd3pbvav1jVvImOwjWUyTfAlG131iCDH
	 VwEa/0UCviXkxsSYrRvbStpI7uIRCWPwAhNeLdWI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 7.2.15
Date: Sun,  1 Nov 2026 13:56:58 +0100
Message-ID: <2026110111-hypnotic-release-9a2c@gregkh>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

---------------------------
Note, this is the LAST 7.2.y kernel release.  After this one the 7.2.y kernel
tree is end-of-life.  Please move to 7.3.y at this time.

And yes, you aren't imagining things, this one went "end-of-life" a bit sooner
than normal.  But based on the release cycle at the moment, and the number of
pending cc: stable patches in the queue, I figured it was better this way so we
can focus on the latest 7.3.y release as it would require us to keep 8
different branches alive at the same moment, a taxing task under the best of
times.
---------------------------

I'm announcing the release of the 7.2.15 kernel.

All users of the 7.2 kernel series must upgrade.

The updated 7.2.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-7.2.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                       |    2 
 drivers/iio/light/hid-sensor-als.c             |   22 +-
 drivers/platform/cznic/turris-omnia-mcu-base.c |    1 
 fs/exec.c                                      |   11 -
 fs/smb/server/server.c                         |    5 
 fs/smb/smbdirect/accept.c                      |  225 +++++++++++++++++--------
 fs/smb/smbdirect/connection.c                  |   12 -
 fs/smb/smbdirect/internal.h                    |    2 
 fs/smb/smbdirect/listen.c                      |  137 ++++++++++++++-
 fs/smb/smbdirect/socket.c                      |  113 +++++++++++-
 fs/smb/smbdirect/socket.h                      |   42 ++++
 kernel/fork.c                                  |    4 
 net/bluetooth/hci_event.c                      |    9 +
 net/core/skbuff.c                              |    2 
 scripts/link-vmlinux.sh                        |   20 ++
 15 files changed, 498 insertions(+), 109 deletions(-)

André Draszik (1):
      kbuild: link-vmlinux.sh: improve detection of third pass requirement

Christian Brauner (3):
      exec: cancel io_uring requests before de_thread()
      fork: move the coredump and exec checks into create_io_thread()
      fork: don't create io threads once PF_POSTCOREDUMP is set

Daniel Schaefer (1):
      iio: hid-sensor: als: scale each channel individually

Greg Kroah-Hartman (1):
      Linux 7.2.15

Namjae Jeon (1):
      ksmbd: wait for negotiation before receiving another PDU

Radek Podgorny (1):
      Bluetooth: forget a peer's RPA once it advertises its identity address

Ridham Khurana (1):
      platform: cznic: turris-omnia-mcu: Add missing MODULE_DEVICE_TABLE()

Stefan Metzmacher (3):
      smb: smbdirect: don't wait for RDMA_CM_EVENT_DISCONNECTED in smbdirect_socket_destroy_sync()
      smb: smbdirect: release failed pending sockets of a listener
      smb: smbdirect: don't hand out already failed sockets in smbdirect_socket_accept()

Zizhen Liu (1):
      net: skbuff: propagate shared-frag marker in skb_zerocopy()

