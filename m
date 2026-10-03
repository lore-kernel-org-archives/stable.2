Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBED2CCC6;
	Sat,  3 Oct 2026 15:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791040569; cv=none; b=F1tmltZJz8Wv2i8503FlS2i+sjbeI+zV8x9CHaGvuj8kW0D1smm40e8Z28JlYJrdoUvKZXI9ODRfn5OQP7s/dYTpk9tQgFTdxuv1l68JHBD5nOUeBhMS+9b/BCO4tkBajQ9k53+yTcwcbBchbcbcqDUgAKUxdVZaL5LTZA81Mbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791040569; c=relaxed/simple;
	bh=1o6qsDGzIPWjggacSfMf5UuD2bc888iAVaeXiQZs4kw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Dn/zW3rFZh5jQv3DzKaO8zTAtTs9wTrOwzSycHN9gCevrS3RV4deidTzv9Yn0qehTeVjapPM5Oee2QEetXGfA8qZE0SfsJAruV1rXGVwAitqTPX9u2HgCQlUojypS1vqNoDBIN04B+fRYdmAjqyg/Pw2/GZrSs8yHQUD93N0bpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=jRhyCcTO; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="jRhyCcTO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=hnFxMGFUx03Gbaj7bM8u2lfQgpWUu9QoWL/uD2NTK+U=; b=jRhyCcTO80HqwDotSqEC4sl4WL
	/VE6jcHQO+pOGLB06fJGO3MXgYllCGHSK9lwcxswaWnca9ItNu8BplHI9PkSe6PPglGN9jFwaSD1i
	rJ9uHSVN0tP8tp2+lJes+uONCXD9hSSTh50EByJPmRDjyDxaJySSOKnJTE+VGTfTRNibn69hvUgaf
	HPxogbQYkvtNTftNpN2axT1ypD+o2vQi8DsQGyKUtdASPZ5x/+CizIVfWLilQbiSr9xkz7zCsbp9x
	zXkkCAUlf5Z2zbOsVZ+HLeQ8XTXe4ZT7VOJQMzXwWecMiDRdjpNKV99T0E49YiNft6SidwPszsX/U
	9uRnkE0w==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <carnil@debian.org>)
	id 1xD1Sy-001jRd-2V;
	Sat, 03 Oct 2026 15:16:01 +0000
Received: by eldamar.lan (Postfix, from userid 1000)
	id 03385DC0741; Sat, 03 Oct 2026 17:15:59 +0200 (CEST)
Date: Sat, 3 Oct 2026 17:15:59 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Erik Brangs <erik.brangs@gmx.de>, benh@debian.org
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
	linux-bluetooth@vger.kernel.org, 1149377@bugs.debian.org
Subject: [regression 6.12.y] After backport of 980084de4d9b ("Bluetooth:
 btusb: Add ASUS USB-BT540 for Realtek 8761CU") bluethooth not anymore
 working on 0b05:1bef ASUSTek Computer, Inc. Bluetooth Controller (requests
 firmware)
Message-ID: <179104011040.2214689.5921682013387867802@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Debian-User: carnil

Control: forwarded -1 https://lore.kernel.org/regressions/7179104011040.2214689.5921682013387867802@eldamar.lan

Hi

In Debian Erik Brangs reported that after the update from 6.12.107 to
6.12.111, specifically with the backport of 980084de4d9b ("Bluetooth:
btusb: Add ASUS USB-BT540 for Realtek 8761CU") Bluetooth is not
anymore working, the full report is found at
https://bugs.debian.org/1149377 .

| [   38.135482] Bluetooth: hci0: RTL: btrtl_initialize: key id 0
| [   38.135486] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761cu_fw.bin
| [   38.135751] snd_hda_intel 0000:08:00.1: bound 0000:08:00.0 (ops amdgpu_dm_audio_component_bind_ops [amdgpu])
| [   38.138313] input: HDA ATI HDMI HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:03.1/0000:06:00.0/0000:07:00.0/0000:08:00.1/sound/card1/input11
| [   38.138410] input: HDA ATI HDMI HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:03.1/0000:06:00.0/0000:07:00.0/0000:08:00.1/sound/card1/input12
| [   38.138478] input: HDA ATI HDMI HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:03.1/0000:06:00.0/0000:07:00.0/0000:08:00.1/sound/card1/input13
| [   38.138534] input: HDA ATI HDMI HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:03.1/0000:06:00.0/0000:07:00.0/0000:08:00.1/sound/card1/input14
| [   38.138657] bluetooth hci0: firmware: failed to load rtl_bt/rtl8761cu_fw.bin (-2)
| [   38.138860] bluetooth hci0: firmware: failed to load rtl_bt/rtl8761cu_fw.bin (-2)
| [   38.138874] bluetooth hci0: firmware: failed to load rtl_bt/rtl8761cu_fw.bin (-2)
| [   38.138877] bluetooth hci0: Direct firmware load for rtl_bt/rtl8761cu_fw.bin failed with error -2
| [   38.138881] Bluetooth: hci0: RTL: firmware file rtl_bt/rtl8761cu_fw not found
| [   38.194794] snd_hda_codec_realtek hdaudioC2D0: autoconfig for ALC887-VD: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
| [   38.194806] snd_hda_codec_realtek hdaudioC2D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
| [   38.194809] snd_hda_codec_realtek hdaudioC2D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
| [   38.194812] snd_hda_codec_realtek hdaudioC2D0:    mono: mono_out=0x0
| [   38.194815] snd_hda_codec_realtek hdaudioC2D0:    inputs:
| [   38.194817] snd_hda_codec_realtek hdaudioC2D0:      Rear Mic=0x18
| [   38.194820] snd_hda_codec_realtek hdaudioC2D0:      Front Mic=0x19
| [   38.194822] snd_hda_codec_realtek hdaudioC2D0:      Line=0x1a
| [   38.208365] snd_hda_codec_realtek hdaudioC0D1: autoconfig for ALC898: line_outs=3 (0x14/0x15/0x16/0x0/0x0) type:line
| [   38.208384] snd_hda_codec_realtek hdaudioC0D1:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
| [   38.208387] snd_hda_codec_realtek hdaudioC0D1:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
| [   38.208390] snd_hda_codec_realtek hdaudioC0D1:    mono: mono_out=0x0
| [   38.208392] snd_hda_codec_realtek hdaudioC0D1:    inputs:
| [   38.208394] snd_hda_codec_realtek hdaudioC0D1:      Rear Mic=0x18
| [   38.208396] snd_hda_codec_realtek hdaudioC0D1:      Front Mic=0x19
| [   38.208398] snd_hda_codec_realtek hdaudioC0D1:      Line=0x1a
| [   38.237349] input: HD-Audio Generic Rear Mic as /devices/pci0000:00/0000:00:08.1/0000:0a:00.4/sound/card2/input15
| [   38.237414] input: HD-Audio Generic Front Mic as /devices/pci0000:00/0000:00:08.1/0000:0a:00.4/sound/card2/input16
| [   38.237517] input: HD-Audio Generic Line as /devices/pci0000:00/0000:00:08.1/0000:0a:00.4/sound/card2/input17
| [   38.237541] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:01.3/0000:01:00.2/0000:02:04.0/0000:03:00.0/sound/card0/input20
| [   38.237619] input: HDA Creative Rear Mic as /devices/pci0000:00/0000:00:01.3/0000:01:00.2/0000:02:04.0/0000:03:00.0/sound/card0/input21
| [   38.237651] input: HD-Audio Generic Line Out as /devices/pci0000:00/0000:00:08.1/0000:0a:00.4/sound/card2/input18
| [   38.237712] input: HD-Audio Generic Front Headphone as /devices/pci0000:00/0000:00:08.1/0000:0a:00.4/sound/card2/input19
| [   38.237778] input: HDA Creative Front Mic as /devices/pci0000:00/0000:00:01.3/0000:01:00.2/0000:02:04.0/0000:03:00.0/sound/card0/input22
| [   38.239278] input: HDA Creative Line as /devices/pci0000:00/0000:00:01.3/0000:01:00.2/0000:02:04.0/0000:03:00.0/sound/card0/input23
| [   38.239482] input: HDA Creative Line Out Front as /devices/pci0000:00/0000:00:01.3/0000:01:00.2/0000:02:04.0/0000:03:00.0/sound/card0/input24
| [   38.239593] input: HDA Creative Line Out Surround as /devices/pci0000:00/0000:00:01.3/0000:01:00.2/0000:02:04.0/0000:03:00.0/sound/card0/input25
| [   38.239799] input: HDA Creative Line Out CLFE as /devices/pci0000:00/0000:00:01.3/0000:01:00.2/0000:02:04.0/0000:03:00.0/sound/card0/input26
| [   38.241509] input: HDA Creative Front Headphone as /devices/pci0000:00/0000:00:01.3/0000:01:00.2/0000:02:04.0/0000:03:00.0/sound/card0/input27
| [   38.252148] intel_rapl_common: Found RAPL domain package
| [   38.252153] intel_rapl_common: Found RAPL domain core
| [   38.285591] usbcore: registered new interface driver ath9k_htc
| [   38.287837] usb 1-9: firmware: failed to load ath9k_htc/htc_9271-1.dev.0.fw (-2)
| [   38.287850] usb 1-9: firmware: failed to load ath9k_htc/htc_9271-1.dev.0.fw (-2)
| [   38.287860] usb 1-9: firmware: failed to load ath9k_htc/htc_9271-1.dev.0.fw (-2)
| [   38.287863] usb 1-9: Direct firmware load for ath9k_htc/htc_9271-1.dev.0.fw failed with error -2
| [   38.368469] Adding 33487868k swap on /dev/sda6.  Priority:-2 extents:1 across:33487868k SS
| [   38.748227] audit: type=1400 audit(1790704634.157:2): apparmor="STATUS" operation="profile_load" profile="unconfined" name="brave" pid=1418 comm="apparmor_parser"
| [   38.748260] audit: type=1400 audit(1790704634.157:3): apparmor="STATUS" operation="profile_load" profile="unconfined" name="Discord" pid=1413 comm="apparmor_parser"
| [   38.748306] audit: type=1400 audit(1790704634.157:4): apparmor="STATUS" operation="profile_load" profile="unconfined" name="vscode" pid=1426 comm="apparmor_parser"
| [   38.748347] audit: type=1400 audit(1790704634.157:5): apparmor="STATUS" operation="profile_load" profile="unconfined" name="balena-etcher" pid=1417 comm="apparmor_parser"
| [   38.748381] audit: type=1400 audit(1790704634.157:6): apparmor="STATUS" operation="profile_load" profile="unconfined" name="crun" pid=1427 comm="apparmor_parser"
| [   38.748419] audit: type=1400 audit(1790704634.157:7): apparmor="STATUS" operation="profile_load" profile="unconfined" name="busybox" pid=1420 comm="apparmor_parser"
| [   38.748470] audit: type=1400 audit(1790704634.157:8): apparmor="STATUS" operation="profile_load" profile="unconfined" name="chrome" pid=1424 comm="apparmor_parser"
| [   38.748511] audit: type=1400 audit(1790704634.157:9): apparmor="STATUS" operation="profile_load" profile="unconfined" name="buildah" pid=1419 comm="apparmor_parser"
| [   38.748556] audit: type=1400 audit(1790704634.157:10): apparmor="STATUS" operation="profile_load" profile="unconfined" name="cam" pid=1421 comm="apparmor_parser"
| [   38.748595] audit: type=1400 audit(1790704634.157:11): apparmor="STATUS" operation="profile_load" profile="unconfined" name="chromium" pid=1425 comm="apparmor_parser"
| [   39.218164] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
| [   39.218168] Bluetooth: BNEP filters: protocol multicast
| [   39.218175] Bluetooth: BNEP socket layer initialized
| [   39.363652] usb 1-9: ath9k_htc: Transferred FW: ath9k_htc/htc_9271-1.4.0.fw, size: 51008
| [   39.440211] Generic FE-GE Realtek PHY r8169-0-400:00: attached PHY driver (mii_bus:phy_addr=r8169-0-400:00, irq=MAC)
| [   39.442083] NET: Registered PF_QIPCRTR protocol family
| [   39.614314] ath9k_htc 1-9:1.0: ath9k_htc: HTC initialized with 33 credits
| [   39.640566] r8169 0000:04:00.0 enp4s0: Link is Down
| [   39.845845] ath9k_htc 1-9:1.0: ath9k_htc: FW Version: 1.4
| [   39.845849] ath9k_htc 1-9:1.0: FW RMW support: On
| [   39.845851] ath: EEPROM regdomain: 0x809c
| [   39.845853] ath: EEPROM indicates we should expect a country code
| [   39.845855] ath: doing EEPROM country->regdmn map search
| [   39.845856] ath: country maps to regdmn code: 0x52
| [   39.845857] ath: Country alpha2 being used: CN
| [   39.845859] ath: Regpair used: 0x52
| [   39.849223] ieee80211 phy0: Atheros AR9271 Rev:1
| [   39.854386] ath9k_htc 1-9:1.0 wlx30b5c211d175: renamed from wlan0
| [   41.745845] wlx30b5c211d175: authenticate with 1c:ed:6f:bb:ed:4c (local address=30:b5:c2:11:d1:75)
| [   41.745849] wlx30b5c211d175: send auth to 1c:ed:6f:bb:ed:4c (try 1/3)
| [   41.807272] wlx30b5c211d175: authenticate with 1c:ed:6f:bb:ed:4c (local address=30:b5:c2:11:d1:75)
| [   41.807275] wlx30b5c211d175: send auth to 1c:ed:6f:bb:ed:4c (try 1/3)
| [   41.813896] wlx30b5c211d175: authenticated
| [   41.816186] wlx30b5c211d175: associate with 1c:ed:6f:bb:ed:4c (try 1/3)
| [   41.821911] wlx30b5c211d175: RX AssocResp from 1c:ed:6f:bb:ed:4c (capab=0x1431 status=0 aid=5)
| [   41.828348] wlx30b5c211d175: associated
| [   41.948210] wlx30b5c211d175: Limiting TX power to 20 (20 - 0) dBm as advertised by 1c:ed:6f:bb:ed:4c
| [   42.675206] r8169 0000:04:00.0 enp4s0: Link is Up - 1Gbps/Full - flow control rx/tx
| [   45.079778] kauditd_printk_skb: 119 callbacks suppressed
| [   45.079783] audit: type=1400 audit(1790704640.485:131): apparmor="ALLOWED" operation="capable" class="cap" profile="Xorg" pid=1955 comm="Xorg" capability=12  capname="net_admin"
| [   45.272603] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
| [   46.036834] audit: type=1400 audit(1790704641.445:132): apparmor="STATUS" operation="profile_load" profile="unconfined" name="docker-default" pid=2246 comm="apparmor_parser"
| [   46.186122] evm: overlay not supported
| [   46.358551] Bridge firewalling registered
| [   46.408480] Initializing XFRM netlink socket
| [   46.552168] audit: type=1400 audit(1790704641.957:133): apparmor="ALLOWED" operation="capable" class="cap" profile="Xorg" pid=1955 comm="Xorg" capability=12  capname="net_admin"
| [   67.792012] Guest personality initialized and is inactive
| [   67.792063] VMCI host device registered (name=vmci, major=10, minor=260)
| [   67.792065] Initialized host personality
| [   67.799049] NET: Registered PF_VSOCK protocol family
| [   68.979467] systemd-journald[544]: Time jumped backwards, rotating.

the device now requests rtl_bt/rtl8761cu_fw.bin firwmare (assumtion the device
had previously working firwmare but with adding support for ASUS USB-BT540 for
Realtek 8761CU, tries to load the not avaialble firmware and get not
functional? I'm looping in Ben Hutchings which has much more experience on that
on our end.

#regzbot introduced: f05baf6e0680d8c10d2fbbc5953848fc3e3db957
#regzbot link: https://bugs.debian.org/1149377

Maybe the answer is simply here, Debian needs to provide the firmware from now
on in the firmware-realtek in stable?

Regards,
Salvatore
