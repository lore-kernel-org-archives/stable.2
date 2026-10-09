Received: from mail.16bc.ru (unknown [185.12.231.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181C344F561
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 19:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.12.231.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791574301; cv=none; b=M7mHH7T2is60LeESukML/y8JXxsjdFxvXqK6+9ah9Ogv5dFqm/B+BPlDF367hnhTRwbcCUcEprx8FBlYOz7lqkPGtK9JGqqEvdpmBDzx8KAvZFaJ3aluv7fhQ9NW+zJ18xhMdMHHTw/cNtQkDITSwU7xQjsEyog8MUx38x7XB7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791574301; c=relaxed/simple;
	bh=GfWxa8ttEdOMSsaD83nYwxkjvSYjAL4dECdJ4H/OZYo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=le7CXg0U3eGQrtkdjLvh9AcRmwK6ZlLnlYA7zdhqmyugCJQin+oM5cMN6esLR/SwYfPGKI8oubtoqmDnjRFDDDMNaKC3fOrCghU4xIwT50vzYIXCXvvBdFLi5nWL6/+sVsI7Fb/3VTvItmfhh7Q0lwYA2cgQ5qcJzPFSq+C3MQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=16bc.ru; spf=pass smtp.mailfrom=16bc.ru; dkim=pass (2048-bit key) header.d=16bc.ru header.i=@16bc.ru header.b=GwS1tgOb; arc=none smtp.client-ip=185.12.231.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=16bc.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=16bc.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=16bc.ru header.i=@16bc.ru header.b="GwS1tgOb"
Message-ID: <7afbbd73-a09b-48d4-a534-4b38ffc3e191@16bc.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=16bc.ru; s=dkim;
	t=1791573883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5TClRSHvBLuqjNOR2UuxtWxKbF4QbqomqI4ILgEdNag=;
	b=GwS1tgObUUdAVsKGAjObtQF1u1D0G5W8IHW4X3a8idCVAd2AT7eeFnPd+9NXNopvuS3NQj
	et8bP4F2BogGOd1IIELKt5dWq3ZSNdKpF8MS5V6+3Q/LmJ1wDIBVpLUE6P17JQTw572xuw
	DA3gophGVPZ+bhO3Doy9B3jmH6zCMBMgBXKNSDScTl+R6mKWKKHgkZQEwLn1cuKFR/5D69
	WTFyTXzmfZ/4SyxRuXzMms1QtIbdGlD9V/Xs+csvWoyAfuaArVnOMfVBVLYwrHNUhayE9T
	cfX1Y97WSbgoPN1CnIHBzDeH0UFYTcjdnqr+42rWWcd/Ezr+fjgXIt5dSFee4g==
Authentication-Results: mail.16bc.ru;
	auth=pass smtp.mailfrom=info@16bc.ru
Date: Sat, 10 Oct 2026 00:24:42 +0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
 Kamlesh Chhetty <kamleshkc2002@gmail.com>
From: Eli D <info@16bc.ru>
Subject: Backport request for 7.0.y and 7.1.y: 6485da8579e2 (ALSA: hda: Add
 Lenovo Legion 7i 16IAX7 17AA3874 quirk)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /

Hello,

I would like to request a backport of the mainline commit

   6485da8579e2  ALSA: hda: Add Lenovo Legion 7i 16IAX7 17AA3874 quirk

into the 7.0.y and 7.1.y stable series.

Why it qualifies. The commit adds a device ID and a quirk entry for a 
machine
whose built-in speakers are completely silent without it. Per the stable 
rules
this falls under both accepted categories: it fixes a real user-visible 
problem,
and it merely adds a device ID. The change is three added lines across 
two files,
touches only static quirk and property tables, and cannot affect other 
hardware.

The problem. On Lenovo Legion 7 16IAX7 with Realtek ALC287 codec SSID 
17aa:3874
and CSC3551/CS35L41 speaker amps, cs35l41-hda fails to probe the amps:

   Failed property cirrus,dev-index: -22
   error -EINVAL: Platform not supported

and the Realtek codec never selects ALC287_FIXUP_CS35L41_I2C_2 for that 
SSID, so
the amps are not linked to the speaker output and the built-in speakers stay
silent. Headphones are unaffected, which makes it easy to miss.

Testing. I reproduced and verified the fix on a Lenovo Legion 7 16IAX7 
(board
82TD), ALC287 SSID 17aa:3874, PCI SSID 17aa:382b, two CS35L41 amps, 
running a
7.0-series Ubuntu kernel. After applying the change both amps probe and 
bind,
firmware loads, the dev-index error disappears and speaker playback works.

The commit is first present in v7.2, so 7.0.y and 7.1.y do not have it. 
It has no
Cc: stable tag, hence this request. There are no prerequisites; the 
patch applies
on its own.

For reference, sibling Legion quirks in the same code path were Cc'd to 
stable,
for example d35dfb6329ac (ALSA: hda/realtek: Fix speakers on Legion Pro 
7 16ARX8H
with codec SSID 17aa:38a7).

If you prefer an explicit patch submission rather than a pickup request, 
I can
send one.

References:
   commit: 
https://github.com/torvalds/linux/commit/6485da8579e2b0132630faa1ee2ac72ccaf01501
   thread: 
https://patch.msgid.link/20260622172247.19301-1-kamleshkc2002@gmail.com
   kernel bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=221663
   Ubuntu bug: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2157060

Thanks,
Eli D
info@16bc.ru

