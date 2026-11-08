Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=89.58.8.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794145011;
	b=JFUcI2pbuzhW8fS1gEWbZC1h1TTA3aMqJi1gdBT14uyHMeG3lLdopE1OH8DRuA7Lhu8/
	 mbNRgT2DADmWF0UsbdHcxBPb6pIgnbkIuKMZt05yiY8iWrX3IPJXvan9EauCkzi6Lybl5
	 siy+G6oG3fXGdzV2CyHCK53JU6c+p5zUJFXx7o1glKn17UpD9whCRq/C1yUDIt6bsrT6p
	 QjQrkBHg77pqYHsDM9PjRhX0AN7QwwEIwfVPakl6Ue8UpzNoOawJ5PaKHxcXtHwjbdOsG
	 dJR6wF1+d7SSVex3yanjiU2UOnk86rFLg0n+PR6R23IKqU/VclR3vUgwXhI/j+dYIjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794145011;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ksfeohUu2MOYYJCfG6rnR7jwX7L3AOvI7nh2YtUJ5tw=;
	b=LRAcyjw7hJ22Rr5QVbrpqYXcKnkZf7yuP1VZTZNyWT4bIU/pe24/3Zz4BfNLJ4D2kFhd
	 skqOyskovwA+bLVy/IH49VpjfhvuhDaXqoQMGUhbtMBxc1QXGdDk9882zeY8T5nBly80V
	 YLlaP+kwkPKsUyjMy+ZwiYgi/BWhz4DWl3AAaQZ6D3ej2zySwbFiiPjaspHEOGAET1GWx
	 VTB71C69t+dnxUVaNzMsA6R2v6QeY5qX5GEqfsUKS3rAFU6CJ5m1xggAXvrewURQhFDS+
	 spmUzLZjn5s7YnrpaBTnu3PTsXaJ11cisCr+3ngtpfOfBIdaUzKYfc4VAUqLk1NWLYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wagner-flo.de;
	spf=pass smtp.mailfrom=wagner-flo.de;
	dkim=pass header.d=wagner-flo.de header.i=@wagner-flo.de header.a=rsa-sha256 header.s=fuldigor header.b=jLbol+X8;
	arc=none smtp.remote-ip=89.58.8.210
Received: from fuldigor.wagner-flo.de (fuldigor.wagner-flo.de [89.58.8.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E810B606A320;
	Sun,  8 Nov 2026 13:36:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E810B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wagner-flo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wagner-flo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=wagner-flo.de header.i=@wagner-flo.de header.a=rsa-sha256 header.s=fuldigor header.b=jLbol+X8
Received: from teclador (p4fe8fa45.dip0.t-ipconnect.de [79.232.250.69])
	by fuldigor.wagner-flo.de (Postfix) with ESMTPSA id 18E401EC71;
	Sun, 08 Nov 2026 14:36:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=wagner-flo.de;
	s=fuldigor; t=1794145002;
	bh=cj56BryqCAaDQKgw9207kfTg1TbElKjmb1l6QWsloKc=;
	h=Date:From:To:Cc:Subject;
	b=jLbol+X8vCXSJ2EJ+GmuF2GI6LhU+cZEnobAw0gz2/sBvI56oQ/Y/EAJQtvKtAS7Q
	 xJ+o014/q2dYMWace55zO8CN1tocQb7hqhXc+v+lFozb+u25b895p5d+EBLGyXNxX4
	 B2FBbfOQDNTw5nmSwV2t2lQm/Qiwj/6vPsmBDsGE=
Date: Sun, 8 Nov 2026 14:36:40 +0100
From: Florian Wagner <florian@wagner-flo.de>
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, linux-acpi@vger.kernel.org,
 rafael@kernel.org, sashal@kernel.org
Subject: [REGRESSION 6.18.y] ACPI: button: lid events lost since 6.18.57,
 please backport a004b8f0d3bc
Message-ID: <20261108143640.6252e6a8@teclador>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-unknown-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hey there,

Claude did most of the work on this one, but it looks valid from the
point of view of my (very little) kernel dev experience.

Please backport the following upstream commit to 6.18.y:

  a004b8f0d3bc ("ACPI: button: Enable wakeup GPEs for ACPI buttons at
  probe time")

It fixes a regression that 6.18.y picked up in 6.18.57 and that is
still present in 6.18.62.

Background: 6.18.57 received 52d864019636 ("ACPI: button: Convert the
driver to a platform one") as a dependency of fe80251152fe ("ACPI:
button: Fix ACPI GPE handler leak during removal"), together with
57c31e6d620f ("ACPI: scan: Use acpi_setup_gpe_for_wake() for
buttons"), which fixes the former. Since 57c31e6d620f, button wakeup
GPEs that have handler methods are no longer enabled at runtime.
Upstream fixed this in v7.1 with a004b8f0d3bc, but that commit is
tagged "Cc: stable # 7.0+", so it was never picked up for 6.18.y,
even though 6.18.y now carries the commit it fixes.

Symptoms on my laptop (FUJITSU LIFEBOOK U9311, BIOS 2.54) with the Void
Linux kernel packages:

- 6.18.52: lid works, acpid receives "button/lid LID close/open".
- 6.18.62: the "Lid Switch" input device (PNP0C0D:00) emits no SW_LID
  events at all (evtest shows nothing), so closing the lid does not
  suspend the machine. /proc/acpi/button/lid/LID/state still toggles
  correctly, and closing the lid wakes the machine from a manually
  triggered suspend, which suggests the GPE is only armed for wakeup.
- On 6.18.62, GPE 0x24 shows "disabled" in
  /sys/firmware/acpi/interrupts/ while it is "enabled" on 6.18.52.
  Writing "enable" to it restores lid events.

Backport note: a004b8f0d3bc applies to 6.18.60 and 6.18.62 with
offsets, but does not build as is, because struct acpi_button has no
"dev" member in 6.18.y. Using &button->pdev->dev in the two dev_dbg()
calls is sufficient. With that change, drivers/acpi/button.o and
drivers/acpi/acpica/evxfgpe.o build cleanly with W=1 on 6.18.62. The
adjusted patch is attached for reference.

I sadly haven't had the time to build a patched kernel to actually test
this.

Thanks,
Florian Wagner

#regzbot introduced: v6.18.52..v6.18.60
