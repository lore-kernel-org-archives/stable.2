Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3141922FD
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 00:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791075115; cv=none; b=Whl1IyYwEWgx2eF+uWsBUMVcPyFw587ltqhTE8/f+1vc9WNfbQmASr6h2jDVCV05Hm0ZwuijEM7qQUlwKK5FKGIFAWfm9xeR2jt3rE1yoN9CFfvgeNf0XhgRMe1kBSsdK2fAh0v5TzrLA9q5YqKFUlozL3MakMeJEKTclGDIOFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791075115; c=relaxed/simple;
	bh=+xXRChb7pRTKeEKacaBfsTdJsfEptT6xDoTfO6eJkpA=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=LpNDk9a25Yd75X6PdxtacvfTkB6RTECZUGdbM38WbgjB/Rh+sGWflUdS6+BcgGi5nLIYD6qeaNTA92LBF73Ui2AgavGcJv9PgYM70QGvXybx1QjfW1wSm6cvzdO6SClpuQpVeW0V6a7ddSgkgj/VrS7sp3d0eFIhnu1RAuaItaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=kSqBw0Wb; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="kSqBw0Wb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1791075102; x=1791334302;
	bh=+xXRChb7pRTKeEKacaBfsTdJsfEptT6xDoTfO6eJkpA=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=kSqBw0WbR/0gTff/dbPKzurZq9fdCYlKgko5qUzlv4Jllsby2isilo9777hI+ugkx
	 jM9lcbUDWvESLDMznr2FKvofHEVWKLigRpz7advQvpLYzgiXl8wBH0fP1EdhQm3TYF
	 DM6dSVULvA8pXhMF5aLmARdZj0PN7oh4A5Qd7PDyI1zMmEQbJLzY9wB65HLLMXBAaQ
	 zrlOUhfCeQ4y7qroMYjTo/aXtAg4kCphHmOaW4ICWbE/QNjnKkH4nugPpEwGkWJkNn
	 t1NWVaTUeWNf1kyaTfHufZQMteoZnYuF4BhYJx2iZPWP2tYGw9KiDRkfzCtJ5NrzEG
	 BqwVTNWcG7SgA==
Date: Sun, 04 Oct 2026 00:51:40 +0000
To: "rafael@kernel.org" <rafael@kernel.org>
From: Charis Stratakis <c.stratakis@proton.me>
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [REGRESSION] thermal: core: battery data corrupted after resume on ThinkPad P1 Gen2 since d33e89d12295
Message-ID: <37N_jFulf7n-Z55NfKfE71C_wVPxYvZ0xD_iRUg2fXu7TypDiF5PStQ6siSfVBih6fThg5WoPes8U5ZQpfVm_teMFcUGXFxz2DdMbfSWuws=@proton.me>
Feedback-ID: 224044180:user:proton
X-Pm-Message-ID: 9b9be756796ff897da51b7220e70e8d7add16813
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On my ThinkPad P1 Gen2 with Fedora 44 I've noticed that the battery=C2=
=A0percentage started showing garbage values, mainly showing less, while th=
e battery was fully charged.

I enlisted the help of Claude to help me debug this so I am providing the r=
esults here. All the testing was done on my laptop and no vanilla kernel wa=
s installed. Started with Fedora's build of 7.1.6 and currently I'm on 7.2.=
8 with the same results.

Since v7.1, _BIX and _BST data read after resume from S3 on my Lenovo Think=
Pad P1 Gen2 (latest BIOS 1.57) is often garbage, energy_full 327.97 Wh (des=
ign 78 Wh), voltage_min_design 32.8 V, serial changes, or energy_now ~328 W=
h giving 424%, reported percentage wrong until the next re-read. Same sympt=
om as https://bugzilla.kernel.org/show_bug.cgi?id=3D218881, fixed in 494c7d=
055081 ("thermal: core: Change PM notifier priority to the minimum").

#regzbot introduced: d33e89d12295
#regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218881

Out of the suspend/resume cycles I logged on this machine, the battery data=
 came back corrupted in 0 of 39 on 7.0.11-7.0.14, 14 of 22 on 7.1.6-7.1.13 =
and 5 of 12 on 7.2.5. 7.2.8 and mainline still carry the same code.

d33e89d12295 dropped the INT_MIN-priority PM notifier and starts thermal zo=
ne resume from dpm_complete(), so INT3403 _TMP now runs concurrently with t=
he ACPI battery driver's _BIX refresh in battery_notify().

Claude provided this explanation for the "firmware confusion" left unexplai=
ned in 494c7d055081:

the DSDT method \GTST, called by every INT3403 _TMP, writes the EC page sel=
ector (HIID =3D 0x60) without taking the BATM
mutex that the battery methods hold while paging through the same EC window=
. EC register trace (ec.c dyndbg) at resume:

=C2=A0 =C2=A0 WR 81=3D02 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<- GBIX (=
_BIX) selects battery page 2
=C2=A0 =C2=A0 WR 81=3D60 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<- GTST f=
rom a concurrent _TMP
=C2=A0 =C2=A0 RD a2->3a a3->80 =C2=A0 =C2=A0<- _BIX reads "design voltage" =
=3D 0x803A

Test: 3 suspend/resume cycles (rtcwake + systemctl suspend), checking /sys/=
class/power_supply/BAT0/{energy_full,voltage_min_design,serial_number} afte=
r each. int3403_thermal loaded: 3/3 corrupted. Unloaded: 3/3 correct.

I did not bisect though, the analysis of the responsible commit was perform=
ed statically, happy to test patches, and can provide the DSDT/SSDT dump an=
d full EC trace.

This issue seems also similar to https://bugs.launchpad.net/ubuntu/+source/=
linux/+bug/2070441

Regards,
Charalampos Stratakis
