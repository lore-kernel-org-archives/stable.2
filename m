Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3178F47D468
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 18:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785523969; cv=none; b=eJ2h7wcgw0gqtH7S5vUFC2NTtg8HC9h0DJlDwJUT2af1sAxN0VdaFHKnpLrKIoNOrStPWWZXu/C0dikKKKfYgZ2JAdUOxw7GV5BnzY+m5Kcnbvoa9QfiBrHYyiCP9bU94NmDUkunkVX2ScSrv7ETIkNy1LpShK+asi//+1SoBBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785523969; c=relaxed/simple;
	bh=2l13kwnHyuQmPvLqxp+PkGG3DysjEhzCki/OcbFBYzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z/mDDyY8BV4+rFh8lse1K1zbSfkJtq0+ud6BrzvMxAq2iTdCEnrIBz1vD/+8gzs41KvMdKjtJJf1LVCkWPDlRFBUkLJKFMjXS20QMVQ0UkD4UANCRwisikOJlHaChtYUQISJzJp0jCg+42L9wrzu0Tpzjl0E8qyBPtV3rpYCqyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lPK6flq6; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPK6flq6"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c9aea40d799so759192a12.0
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 11:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785523965; x=1786128765; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EdUk/9fNoAPKGyul4Lsecqk1JfbtoXZPx1UcmlbESJc=;
        b=lPK6flq6sbu8DP6U4WdEEnggUhxNkHwDl+oNIqVFOTJBMMOVgXpeTDobz9y3xR+2Jr
         BB2LefqlosrIcP5/Qaw/Jtc42yCcuZq8qlxchNk3Fn3Sjpn/6ezA13jXY8LSxQitkocv
         zziF7XX9Uxqjbg2mAg+dNMBETfXvYV+5q0Y0ayMZffrgCxj3eFGkTjB7SrpZPJ1Std4C
         LMbtW/q7ToDEf3NE1hTyzwqwdzMR8MKLkdShtWi63uTVzlD4oG4RlHhaHuqdv/aHmTZz
         TtDDhbGWGCXbeNp26yXTzU7cn3Lo+9eLbBauauCE3faM3NlZFvI23iT6nqu4q+zqfrBF
         mkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785523965; x=1786128765;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EdUk/9fNoAPKGyul4Lsecqk1JfbtoXZPx1UcmlbESJc=;
        b=Z5AGkU/FEJi7YJgorwJCmPiw24Oo9uHHNdomq1QY7HbgJ5k5c9NFOnGXMP+CBSviqx
         ULCN/d7E6sEvCNv5mtLgFFOwrnztgNE0BFRy3vKap7XgJsMAHMGJGcMXMH+bg2h1mgjT
         ILw+7vpOv2avxrRjETbhWzdvqSZdzWgIT79TvevegfmgreQXi8j1P/UZ5S1dT8tXXptv
         VVUs86Vla3Kl66cwSSBUReXzwqWh8pYRel4ddPa5+a/YLJh2bLRQD2VdYg4mOyllUjZI
         cITRa5PEKPle1PdV4xTcXxRR00gbjLHwpmjUt+BhE9USx/Ct5U7ApWgGwwXTT6Ql5oAR
         v71w==
X-Forwarded-Encrypted: i=1; AHgh+Rrh+3/6h/Rt0vwAsO+o51mhkUq1L42K8FNG/C/YFt2znvzRmJLTK5e2nYC9BRMItQmzxktGnIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5RaZ3crDXlG2XywvdI8yngFfPVaKLvArVqMBfkdHchJMDKy/E
	F2icqrPOT4deYbm0khEMUYVdTlx7nzVKsqiDJj94G8W4CZ5eT+C80xaO
X-Gm-Gg: AR+sD12kA9+dBBmjKcCD0zZXGKYZMIOih1SC812Y8d7jtrgRVsd5JEQ4YRZ8wQ87uOS
	QGzVrjwD3IMVdiYW8AP3sJMX/3H3N7YStDEAG1S4ksSOoqQ/76QL61r1WitxZcuVtJF5nHtZt/+
	LTVvIthOM1KDY+PWLG8WXUzr9g01T1rgKJhhp8IQ2cawmwcFWU6RQkuCnvxnot5iIGY3/fgDEfZ
	E3kqkGJMbIId2UNBEcp6cUSyXV4d8rC/CHZES/NsfSOr78KtBGFusXyv7ynEbWSbutRnFOvfDFk
	zRl5sYEG9FyjGhIMPq/e2iyk9powGNNILzw5hFmpGyU1eh6mq+rRCO+Iqd1OlVVTgYBduEZOejr
	LqO+q7ss3HHknjlRwRdHXsJL/GIsfFTtdu+2h6Xc6DIvkOP/W/6eDBh7WUllmkCshJ2CY4EV504
	eVCVS26Qu6ugorxAXx/d8gEw4CGzzd1p5dafbKyRGn6DJxKuJM52xxAiIRTs+VlBgFEN40peFlC
	/N5seKd43o+1G9HWwwwHKed/MzQiQEkLe6J6Gu/anK08UeETgIzed9rTd+VPLeChqkLfhIMl91H
	EPFMR6ROeGSiFfNl6WnN4BeBTh8GZw==
X-Received: by 2002:a05:6a21:a38c:b0:3bf:a489:1483 with SMTP id adf61e73a8af0-3c92a7b05b2mr889355637.33.1785523964667;
        Fri, 31 Jul 2026 11:52:44 -0700 (PDT)
Received: from localhost.localdomain ([2405:acc0:1306:9d5b:957e:789b:fa3a:55bf])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4fdb80sm4965450c88.15.2026.07.31.11.52.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 31 Jul 2026 11:52:44 -0700 (PDT)
From: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btusb: validate QCA rampatch size
Date: Sat,  1 Aug 2026 00:37:38 +0545
Message-ID: <20260731185238.10533-1-acharyalaxman8848@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260730161820.11631-1-acharyalaxman8848@gmail.com>
References: <20260730161820.11631-1-acharyalaxman8848@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Luiz,

I have not yet received confirmation from a Qualcomm engineer.

Shuai, since you recently worked on this QCA rampatch path, could you
please confirm whether requiring the firmware to contain both the complete
device-specific rampatch header and the version structure at ver_offset is
the correct size validation for all entries in qca_devices_table[]?

The proposed minimum is:

	max_t(size_t, info->rampatch_hdr,
	      info->ver_offset + sizeof(struct qca_rampatch_version))

Thanks,
Laxman
