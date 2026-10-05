Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1EF4B66F1
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791214803; cv=none; b=fbB1FiQe+LsvVIRdKWeiyVZzqhw72gVeSMznN2pTnGp2UbNaQPrezGvXzVj/qf+KrUtkQLdELoTqtFbytGDiasUXwk+tRXLoKSoSo6ViIwEc8thEOb6208ZcBHAPfcJPvkMu2+KqNA2i7gGGqKgjfyvcvc2XY+xPCexkNS1uoms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791214803; c=relaxed/simple;
	bh=ba9A40Eocxg6BUjCC0uK7jmLBuw9L87fvv223hooHCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t9QrHcF1tbXhtyo6z23ySHBQq4xOGlouCsnDdgec8h/ssaP9wh5e1ijXot0IB3MFAy+59Lbyqm5m3eSp6vpROd3Z50NVPRzSU7V7xXQxy9MHhZLRdJ34B/H3vz6AqIpFQSwnrAry6m9Um5LyPIg1yCynqwl04AmxT1wOpIwGjlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtOChNb+; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtOChNb+"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6351831so992923f8f.1
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 08:40:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791214797; x=1791819597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r5zceH4jNrBdEqXJOgqRFynavUkkfMoVyT3whsFnol4=;
        b=KtOChNb+gL3oxzpUQpDsCC55P3wlNTpNGtkjfpKc0ZR9KupUB3C1b6BAIKDl/96QIC
         mLizkPXmUyI25HFNt5podcFNKywmCMZQmbzYgDZvZLLm5LT0qKkx09oT9hrQuaiPkSRh
         jGbDR9M+yX0NlaH1rbXJnY5CqQ2VU2POxCbRVBUFlAHhBz26c98Xm7iFV5GeKZmTvY9k
         998XAhBlkEjuGYmMIHT3zYuYnoJWhNqHyB5gyJaajmUeOq8x3JijWsyfHvivHk0+c3ua
         e2xWFaHTkyAkZgkLc9+r9j8tmuTle7+jB+4Qyl+LweXoK1FQb27HhO+xjHW6RwhoYjAK
         +J+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791214797; x=1791819597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r5zceH4jNrBdEqXJOgqRFynavUkkfMoVyT3whsFnol4=;
        b=2IbfNlAGk1fPj5QK7KqzuupmRDwWzIhXIrc7Vm6Lk9Y4z3Qtb0f7GuXiJK+JS/CA35
         yvaXDUJTqwJlau+pmv9coF37lWxfUf7NJkcUiFXc2WEOkP8j4E8+yZrW+BPdhnsiAmSr
         VvlNTwohQKflMIojp9b1ZlZ1lXuHun90PjO+Kf5k7be84AMXilprjzR385zs/3XY8N8I
         xLE20BtQujZnbqw6VaIx/n+2jNhM316mVqqaNhW6OTAa+jb+YgFY5TJGyGlB059DvfZ5
         3WjX1t8yfP4vj/f6YcFDUGnVYOCQI/VOH7+do0l4Icr8P+nZF1G94cQcarRnfTdO9DT8
         pDaw==
X-Gm-Message-State: AFq9FYL7txHr4UoKb26gBH8DAucurCO9oPg1PNnUXG0sU0okubI3lira
	1htcuWJvgPOJEW1M60IfvIa3GLtbGh/7o6/5VTadTkzByuc2EvPuI4yfovLrvQ==
X-Gm-Gg: AYBFou3PP3Ac14uXF7JyHCSH0y5HZomnbjSi6H42Bfl60fMztB0ZdHFeXJh0+OY8FE/
	XZBNMXX6Cz4u/Z4lO3F+0Z+rZHY6lA6JxooHVSroJqwcnhvLlQfYisC1qDtFKzwdbJLamZP2fTB
	34dZnEMCjmjuDLi7bedyWVIIv65QbqXBo5688stG9Du+yE+di9xCa8v395NlatShgT1RBVzfW2Z
	rUTV2rdSQ5KlbBdLAirRJ7lDx9GDT4Wtimds6KFC3IU58wMuKYFjz7/UOgSKtxW9fNezCEN5duw
	P4UaZ5/Kxc2al0VFKuSdsfhmL2WdpIWej6bzimca3nxDc2Ct8EJahvYBv1ua8dyj/LtC8gijhOO
	9Bm+bZHG+7OqCIpwQ+uZ2H5QG1/6XmVJXiXagpyak+p2H8esM8lwrRxeLlJnjEZk+saC0bxX9Xv
	Mi8hX9hz7MOCISoZ7jhVs/5Ob6NTMV53Dr9vwa3kr3vYSByBq2sRsDUmXVwxqBoOntgDCHODgH0
	MsWdCvWFbctZSg=
X-Received: by 2002:adf:f04f:0:b0:488:88f6:36a9 with SMTP id ffacd0b85a97d-48b12717780mr13929101f8f.21.1791214797488;
        Mon, 05 Oct 2026 08:39:57 -0700 (PDT)
Received: from deb05.proceq.com ([213.160.61.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c622bb172sm9124104f8f.42.2026.10.05.08.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 08:39:56 -0700 (PDT)
From: Mehmet Fide <mehmet.fide@gmail.com>
To: stable@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-mtd@lists.infradead.org,
	mehmet.fide@screeningeagle.com
Subject: Please apply 68fe2faf5c69 ("mtd: rawnand: vf610_nfc: fix false bitflips on reads of erased pages") to the stable trees
Date: Mon,  5 Oct 2026 17:39:56 +0200
Message-ID: <20261005153956.238827-1-mehmet.fide@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

please consider

  68fe2faf5c69 ("mtd: rawnand: vf610_nfc: fix false bitflips on reads of erased pages")

for 5.10.y, 5.15.y, 6.1.y, 6.6.y, 6.12.y, 6.18.y and 7.2.y. It is in
mainline since 7.3-rc6 and applies cleanly to each of them on top of

  37adc9c5789c ("mtd: rawnand: vf610_nfc: fix reads on chips with more than 64 bytes of OOB")

which is already queued for all seven.

Without it the driver reports one corrected bitflip for every erased
page it reads (18035 on a 126 MiB partition on a Colibri VF50, one per
erased page, while raw reads of the same pages return clean 0xff), so
the corrected counter of every Vybrid NAND device grows on every scan
and anything that watches it sees a flash going bad.

Thanks,
Mehmet
