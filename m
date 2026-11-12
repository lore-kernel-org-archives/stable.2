Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794471815;
	b=vovVxnfHeeKMi2OhKmjQNB6VaGUTMgzZB7HZMvcP0yr0/fJD1EbtEPpOPCf1FE/1VHTF
	 A1tPS7iHnLlFcHBG7BeyxXhOpH+h2yKZJBB1ToACwtG0Rn2LBtrXAzQqFwxnlN0CwTgba
	 Ui1ULEhvn/VmqR2YFrc7M8oHSaJ7wdWJwydw+mExMAM+75p62wYBRvdHuYLTMGNz0zu6K
	 GkD5S7z6wtMiiGMKEpU+mXT5LkQD43KSU+O8g14HZ04UKrovCNOkduMRu6yXasQ3qrimS
	 VOJK3CDV65v0Pp/rIurkefeEEQ4S8768OUqN4EWU1vxjL9EYIiPh1yCTJ9nVgLkEIWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794471815;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=qFl/nh4Ko+JVbo/fF38/5LKhuk73dbwlU+27wGlqJZE=;
	b=P4XCB7oXB2s96njUrKkQj8dlB4YzjxrlfnG4tOiqGcvj9ZXl01wJ84MkXVHCC14fsSDS
	 26SpT4gooKh8/rpXu+caq5XpmQtBcf27qjut5bofraSC+tTHcsm61sMhZFTrLTggbnnhS
	 2fP3kUJilik1D0JmZ8cw+k1swi0kLKuusgzRqRq2btXTQUYKVWOdS0jLeTUp9FujiDsDm
	 uD5Ky0IdRuaVsB0u7uVNDbDMdhpZhQg7Ltv1Er88oyCce+EjkxP2JPdDQJ7YWWCKpZeuT
	 VhRYMzJtJ+gEzGuKFOV1Pa77UDDNzDZvtN4p3K0Apy8rk73GQsdTd7Y2ty8L/w0VXHQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CLWFU3jm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB4060A2600;
	Thu, 12 Nov 2026 08:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CLWFU3jm
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794471815;
	b=ICLgAnIQYvV0hM9092G9Vm3gY6iwn1EHESy93DlWsGblPsJDXrl+B4DvcjwYzuqRvM31
	 C1omrvofFN3RyerJzBUYkfgXdiZFENL8R2P/0toisnG1AALBI8Zhwq/VVSgrg0xm/p7YZ
	 R9lCd5zzRFxV89iPOmiVpNeb/IteJDCftXt2aA8RhM3NnkPHpD57qFkQU1LIV6fcdxd+z
	 A/jlEO2ekUESxT8UdRUpwqisIXlpjD3yGwafPhCWV90IXeCmoYkx9fUWVGlV/DWd6jbsk
	 Pf7Wv1ZUl+ZNEpcFiPTr0v//UQtwJzXQgN1hs5/4/RPf01vkjp8m2Y+yCKPFqyi7mIg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794471815;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=qFl/nh4Ko+JVbo/fF38/5LKhuk73dbwlU+27wGlqJZE=;
	b=Gm+6M41eWq4HmFxYt+Gy34e81k9opcb9hZ67bG89P6vyhDqS8xO1LWHwZR7IbcxCZaZS
	 Z0B+EqzecJVuyunf1ouvXTpPRBQMKxEfPe1ArFcg3XS972dbJJ9cWlPN6ZnnFoZk5T0pU
	 txe6Ccoantx6fLII6OjnRHmtEL1XJdjTYECoE37NMIE1gUs7+PaTTDO3Gb0H5lxysLu9Y
	 9bvghJHwU3LTzjUZHbLNlbmDPC5/hCixzjd1IkPfkaR9HHt87S+TCGdzsu86NL/CGxOBo
	 8AcELXKwRD1S0pzST50Y7DRef2tNXQ0oGWSO/MHmzDQ9EhCiGbYt1omwJhILdxh4drA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3E4A81F00A13;
	Thu, 12 Nov 2026 08:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794471815;
	bh=qFl/nh4Ko+JVbo/fF38/5LKhuk73dbwlU+27wGlqJZE=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=CLWFU3jmjcz5b0noF6U9vmFEhf0BEUF02SCtyKQGaIqNbfYHl7yHqmduB06ND+PbZ
	 hImBxs96bIPCXJkypMNL4qcp+5W/VKT/Z2PE8SjT3FtG23fl3St+HsGoLdKXSqGt6z
	 TgYXN8YCAGVZIx077dxgrbMj60tEd7BB3b2bSfqtsIprE820syBl1nOMm8i8uINOOy
	 HPi5d3F/Nr+vWdgHRHNvYdKyhGxLOqTqJRMbqTT32OfY1Im3IFNkp7YUdNZYvFntNS
	 ZjKtoQnTrTgfN9WkGR7l6qOPFM2w5tqeDb7lIpJV2w1pNTYxgPhCUgUNjkZM4PFlgz
	 6gQDBUNT29PEg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C5A164933F;
	Thu, 12 Nov 2026 08:23:32 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Subject: [PATCH v2 0/2] usb: typec: Find a Type-C partner after a warm
 reboot on the Orange Pi 5
Date: Thu, 12 Nov 2026 08:23:32 +0000
Message-Id: <20261112-tcpm-attach-reboot-v2-0-b4bc6ca83490@gmail.com>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBBFr0Jm7Zi2CERX3sOwKNMBxoglbSUaw
 t0F3Lt8yfvvzxA5CEe4ZDMEniSKf65gDhlQb58do7iVwShTaq0VJhoHtClZ6jFw431Cd85d0eb
 lSeUNrMMxcCvvPXqrfxxfzZ0pbaXN6CUmHz7766Q37+/BpFFhVRYVkWbjyF67wcrjSH6AelmWL
 1L3KSXGAAAA
X-Change-ID: 20261110-tcpm-attach-reboot-d93d5f36403b
To: Badhri Jagan Sridharan <badhri@google.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Guenter Roeck <linux@roeck-us.net>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 Arun Iyengar <aiyengar1990@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794471812; l=4299;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=NXoRow5VcVQww5nLiutGQN5/V1+lopLZ2pLFYOB0EcE=;
 b=gweINCXVaFsfWvdDUDRv+bl2hLeAzzJxHEMtI/yKW9mw+LbfV9dTa53yskxM9+gkOdrCKfFO6
 fb+isu7BQsQCPxpusNeLy+ePVu5zFPONAm3bvqz2nQeVlPlxYFxMWny
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com

After a warm reboot, an Orange Pi 5 (RK3588S, FUSB302) often did not
see a Genesys Logic based USB-C to DisplayPort cable that stayed
plugged in: tcpm toggled in SRC_UNATTACHED, the FUSB302 raised no
interrupt at all, and only a replug at the board brought DisplayPort
back. Two changes in this series and one device tree change fix it:

  1. tcpm: tcpm_init() sets two states back to back with the port lock
     held, so the state machine work is queued twice, and the second
     run applies the PORT_RESET -> PORT_RESET_WAIT_OFF transition at
     once: tErrorRecovery (100 ms) took 6 us. A pending delay is now
     re-armed for the time left. This is generic, with Fixes: and
     Cc: stable.
  2. fusb302: toggle with the default Rp current. The FUSB302 found
     the cable within seconds when it toggled with the default current
     (after another device was detached), never while it toggled with
     Rp 3.0A. Once toggling stops on a sink, the driver switches to the
     configured Rp current before it reports the attach, so the sink
     sees that level from the start, as before.

The device tree change, "arm64: dts: rockchip: Mark the Orange Pi 5/5B
Type-C port self-powered" (patch 3 of v1), now goes separately to the
Rockchip tree: the port's VBUS comes from vcc5v0_sys and the board
runs from a separate power input, so tcpm opens CC during error
recovery and the partner sees a real detach at boot. It does not
depend on this series to build, but without patch 1 the open-CC period
at boot is cut short.

Testing, on an Orange Pi 5 with 7.3-based kernels: before, after a
warm reboot the cable was not detected (0 FUSB302 interrupts since
boot) until it was replugged at the board. With the three v1 patches it
was detected on 4/4 boots, the first one starting from that stuck
state, with DP connected 1-2 s after boot; the three were tested
together, not one at a time. The patches have been in every kernel I
have run since; in a later run of 30 reboots with a USB-C DisplayPort
monitor, the partner was attached on 30/30 boots, and the tcpm log of
every boot shows CC opened in PORT_RESET and 100-112 ms spent there
before PORT_RESET_WAIT_OFF. Not tested: other TCPCs (patch 1 is
generic, patch 2 only changes fusb302), and the Orange Pi 5B (same
dtsi).

v2 was tested on the same board with a kernel carrying exactly the v2
changes: on 16/16 warm reboots the partner was attached and DP alt mode
configured, CC was open in PORT_RESET for 100 ms each time, there were
no kernel warnings, and the FUSB302 HOST_CUR field matched the Rp level
of tcpm's last set_cc() on every boot. Three role changes (dual -> sink
-> dual) with the monitor attached each re-attached the partner and DP.
This is a PD port, so the non-PD path that the v2 change to patch 2 is
about was not exercised.

W=1 arm64 builds of drivers/usb/typec at every patch,
and checkpatch --strict are clean.

This series was developed with Claude (Anthropic) as a coding
assistant: it wrote the code and the commit messages, and I reviewed
and tested every change as described above.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Changes in v2:
- Patch 2: switch to the requested Rp current when toggling stops on a
  sink, before the attach is reported; tcpm does not set it again on
  every path (ports without PD) (Sashiko). Fixes: tag added (Sashiko)
- Patch 1 unchanged. Sashiko's pre-existing tcpm_unregister_port()
  race is fixed separately:
  https://lore.kernel.org/all/20261112-tcpm-unregister-timers-v1-1-7230fda5612b@gmail.com/
- Patch 3 (Orange Pi 5/5B DTS) split out; it goes to the Rockchip
  tree on its own
- Link to v1: https://patch.msgid.link/20261110-tcpm-attach-reboot-v1-0-7657cc1e2dca@gmail.com

---
Arun Iyengar (2):
      usb: typec: tcpm: Don't cut a pending state delay short on a re-queue
      usb: typec: fusb302: Toggle with the default Rp current

 drivers/usb/typec/tcpm/fusb302.c | 21 +++++++++++++++++++--
 drivers/usb/typec/tcpm/tcpm.c    | 12 ++++++++++++
 2 files changed, 31 insertions(+), 2 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261110-tcpm-attach-reboot-d93d5f36403b

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


