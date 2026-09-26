Received: from mail-ej2-f26.google.com (mail-ej2-f26.google.com [74.125.228.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F33930D3FD
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 13:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790427835; cv=pass; b=FxtkpjljEmLasUlXnMSJrn5kLiOcGirKqJ9AxhdsaKiDz49nP1VGvU2VcQqYwdTtfS+I3O1nsF2nca5+HtEpo/4q2VI9gzAZ8BbD+kyJ/OLXlXo1rVXgPghgy/1zkA6so3KQJvQ9xQDd42ZCn32UfHz/qebVmL76d41ogIIfBTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790427835; c=relaxed/simple;
	bh=KPB4QfuQyfLFpvVLFN1RqwpJdFRHs9clkHigX3iiJE4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=AV2WRuucyk4TzBNLKWRF4ols4fCCIJj5v7ILpI3uKVf/9frGxHS+20ksP6EhOvWOpOx3bSVOcPacWVp7o2P/jkSTQMI5w84icXOz99sCfevAW9+w7rQP1vMgDZrUPxkCr9TVnAv31Y65UoTt2hpFYcqzsdp1DQhIIO1Ag1A1wq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=Bigq8mBr; arc=pass smtp.client-ip=74.125.228.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Bigq8mBr"
Received: by mail-ej2-f26.google.com with SMTP id a640c23a62f3a-c2940ef15d3so207720466b.2
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 06:03:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790427831; cv=none;
        d=google.com; s=arc-20260327;
        b=Cj+pZfJJNmh7E+3fAogvFi0iF3ejp5mmZtI8lKpwOlIN2MH/c9NvuQsTGyeQZGdcJ6
         +/a/iBcdqoLd5KOCkXadfQn/yStAhqpMCwzq151mgNB5sMTKYllsQD0MZKbLX6Tf/HON
         hsE+w5UgGPeoV6hUJ9eD5ocnv3IH7PQt2ZrOpIQOCt2qwvF8SzBs/xCkR3hF0h0hCLIz
         Dwb3Ha7TKHTgTi9Mg3fXU8liNVqHd/YF0ucWXfaPDmOld0rXi1W+taZdPnnKQSFELl4F
         tw4WtBeyizwwXUqQ/+0dETQL887q3gAgXu1BaO5JTMaZ36f6cy5E+WpKLTX4LZDHLh44
         tLbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=KPB4QfuQyfLFpvVLFN1RqwpJdFRHs9clkHigX3iiJE4=;
        fh=ICGN9nnLs78z7wzfOAFmYlG0CtCWWo8R3sej5/829eE=;
        b=JHmrks/Wcu5l31ULk8KxuEiBgBBCUsOxjKV9IlivZ64Zntms4cTomM9J++pCTyv2Hf
         5p3NmpbH9HgcwtqMnHc2ebFPQArLfF3zVxeR3gu5mdud69REMPlE+P8FdcRKSc/9f86p
         UU2UodTqqd2pVDNrN9GCKA0vm8jqzGPJbAj2s5svsQHX4xfv55XrvU/mMpOh5Yij7E1e
         NJedVSXeGYuMmQjWxCWT4V/0ygo+wlm2zJOHctohytZ1TalsEccgYe2X3CaBeKX1zu/R
         fO0tWdZp2zbnp4GIrIUHnWI9RCVhzX2KaRZTdvHkIVFoxdJGhKqwuw8w9TIhcg1lcK6u
         sWcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1790427831; x=1791032631; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KPB4QfuQyfLFpvVLFN1RqwpJdFRHs9clkHigX3iiJE4=;
        b=Bigq8mBryqX0Ds0N2EipDlro4L+H9O/z3QEvC2R2/KKo2UG8jq1WVXKVj4ImYJmJhC
         /pJNrV1Q2bOU3d+fujPLyzpAz79y5kjycTXtIJX9S5gM22ppi5gPn8dZAGquJK3sdFdk
         oAiAfWfz/vT7ws29OBupl5j8AK8wLNj3jMtANqJnrpMgkyzkudoi0noGIC1Wl275YgvS
         U8yqX2EkPVbMBhX+8nVOkQk3PVxxrVp3iFl3pSmqY0lLw52viRNUyRAmIS94gZzmKP+G
         qHLetdxslS6sQfKbhaoXqj6/fAkkJrz+8sjNt5VSvwvMOsvpW7UtExDW736Vnm/nRx5U
         LVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790427831; x=1791032631;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KPB4QfuQyfLFpvVLFN1RqwpJdFRHs9clkHigX3iiJE4=;
        b=bfkeLw/UQppd2IKoLDmNhZ84/nYclo2s4W89QejAwp0o1Pzos/wMcoXtWUIEsu2Xeg
         KnqG7dg8VOYhaxyp4fh5xijyhJ/rBJ/6Nh1PbqfMo2OFowhmUowtcrhxJ0/560wbvGt6
         5pnppFlnYWKB3GC4TEOTxiBZtbPFJeBh2ptkF+h6g3YdvahjXHsotpCgRnPOnzUXY7+2
         u2kAaHnR0/AENxkMfliSdWNGOrzudLq4WSQMZlYg4VKmcltakyYlja05yuqlR2R4bd2K
         G9kWotxUE6iufIEDt6/WifKHQRIAUm5AuHfw8ppgv/GyBLoL3XzylcCMbaCDq9vU9BAg
         vLdQ==
X-Gm-Message-State: AFuF++mPwHRL1E4EUZCcO0aVa8ghk4WBtmmjGFQF4CTe2Nyxccudeh4W
	RcXo+Xe8+rbZdVXsQrxdgrOHBSuX239Hwe1H/EmIIfZdhOvZkeRweH4YBSB48xrINndq4ILvJgl
	ZS8lmjyfJYARuunG70BM29J4yyCv6LuAuIKMyz05wL3H9J8s=
X-Gm-Gg: AYBFou3sp8ynwBJEeXX8Gc9fdqRLPJ6IeI3lVp3KAuzMFVhiAPUEBT3XfkQGIp+J4f9
	FKtUqJ7rSPItkgIq8JlT73PP/NDnaKwKMOqNo6p3vGCMan5AhiicXfY6kivxJ+mOd6gCsh7VyEp
	/UzqIo/EkkNGS2w/OppBj4IGCYWn1sAw6NtjGcRINQ2keBEcJHj/2xDWAOFY8fTQTZHk52vzeWR
	KqhbHGCmB5NJtMaeGsiKvtuAc/nZEYEoS4DWMIOAfqzqS8OarKd7ujaRLMRXQKsYBKmXglXW1O1
	f+fbl7DzfyfTWowJi3h3Doy1aQDMOfcpc9Ad22jOe6P7QMfKhB4Odg==
X-Received: by 2002:a17:906:dc8a:b0:c25:2e93:289e with SMTP id
 a640c23a62f3a-c2ac233f3e8mr713822766b.16.1790427831544; Sat, 26 Sep 2026
 06:03:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Faaris Ansari <faarisansari@googlemail.com>
Date: Sat, 26 Sep 2026 14:03:40 +0100
X-Gm-Features: AclHuK952zT1VOkbWHfF6M_lj11z6Tzl9P8Q_FSCl8Jh__qj6jK24voSq9ltu-8
Message-ID: <CANBVYRCL=8QdLxGg4S6qrahrFtwJxhv-aSGpW7-1S=+iOe4ZGA@mail.gmail.com>
Subject: [REGRESSION] Audient EVO4 hardware volume control now requires quirk
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

#regzbot introduced: v7.1.13..v7.2.5

Hello,

A new regression has been introduced between an update on my system
from kernel 7.1.13 to 7.2.5. When attempting to control the volume of
my audio interface (Audient EVO4) through pipewire / wireplumber, it
attempts to modify the hardware volume, then falls back to modifying
the software volume instead. This causes the system volume to be
dramatically lower when modifying it through software. However, moving
the hardware knob very slightly to change the volume brings the
software volume back up to 1.0.

I confirmed this is a kernel regression by reverting only the kernel
on my system back to the working 7.1.13 (now EOL) version, where the
issue did not occur. I also tested both the 6.12 and 6.18 LTS
branches, and the issue also occurred there.
I also worked through troubleshooting this with a WirePlumber
developer to confirm it isn't an issue with the PipeWire stack:
https://gitlab.freedesktop.org/pipewire/wireplumber/-/work_items/1022

I was able to work around the issue by adding extra modprobe config to
my system, specifically the below:

options snd_usb_audio quirk_flags=2708:0006:ignore_ctl_error

Does this quirk need to be added to the snd_usb_audio module or is
there an underlying fix somewhere else?
While troubleshooting I also attempted to patch my kernel with this
patch set hoping it would help with the problem:
https://lore.kernel.org/lkml/20260919151840.24371-1-arc@gmx.li/
The patch set worked fine but this specific problem was still
occurring. Using both the patch set and the quirk above makes the EVO4
work perfectly however.

Would appreciate further guidance on helping to debug.

Thanks,
Faaris
