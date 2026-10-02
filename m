Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FA4361974
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 20:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790972927; cv=none; b=JGc9IQq1h3oWXS8TagPWmr6aeCyqt+rnzRb42M6Zk5Fb6n3eew2tebGllYwpM1NTNal4/YfbgtxDdiJc3lRkezWh+Ev161Nkchl1keEhdQAbe0tPEKVyZE6t2dxfkVaneIxaGLZa8BeUHsIXNxnvio1EsuDZg/U/57r5bVuohuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790972927; c=relaxed/simple;
	bh=D8X1XlYV1xq+RxSSILgm+MOm5JovS9lyKgYPVNdN+s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sIWAMKSxfFFmWGast/pIBIwexud+mAceO53k4YhlTKz3WHBo7E6qzZqPjNLvZx9SS/W8enaPJODIIu56xLpo5r0r9fkiaoFZM14dvOWGugnzHhZa4cNKsqLAhxmT9iFtxBkSPVNCjDKs4jzDu/UmDSHebkEoTJzonCOKgOZtHTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GO3qDnV0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GO3qDnV0"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso1435645e9.3
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 13:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790972924; x=1791577724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D8X1XlYV1xq+RxSSILgm+MOm5JovS9lyKgYPVNdN+s0=;
        b=GO3qDnV0dYMmoFyyJqpNAYbapJBvvuhHH0gvbIWTIEwmvpHXI2HN4agDqg64BUU3yb
         vgVSdzmKd70AoHapXrrSwaXh7w2EvK7TWHEP8iBQyGCNdxXO18C0fN/DEkVC7a0MmZ2r
         VUGL8aUkUZPZFd/99/aHvbYLO2rN3St0FiRK/2iwyrcSjaS6BCgPR6quMz2zvCgdY92b
         Y0oso/psnb7xYyTP1lqjv2gyA0geb8d5QUD6kzSOor2IGV8suTP330FyCh77zkeOrEG6
         R8Q5sQEsp2hWYpUoCofpPeRu3cCwO5xXG76nHqe03w9OhBZlOO7F15hZqVpXPg/VdQ/x
         Iw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790972924; x=1791577724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D8X1XlYV1xq+RxSSILgm+MOm5JovS9lyKgYPVNdN+s0=;
        b=gp00HhuhBGGhy+zJTsGzIigwnPvxj30hyXEPfNYIkdQr/uA38epypsJaNPWtU8wwjl
         pf6BNzrx0YRkmSHKMOharRQkR6V7E2N6k4Xgg1sD85MGGECScneDTn45e5uOkJqzLIyr
         yXWCn8asJgDmyEYJjsWioNQgmnImAUnQQds0lcDdtEB4VyJCqhTHbenfkK6v2L28biEW
         XJIqI687XANuB4bYeEnobALiz3YzbP0k4TfIrb1ddI9eMYB6UcJVY1GvIy6H8QS+zZnp
         if7JHsd3nXrr8BRqgDFMSiGbuYArtiID37IYg+JTfYnyYXtGe86K49il1h/BOEupzcRX
         zq8g==
X-Forwarded-Encrypted: i=1; AKwUvBxYQfTAiY2I6hAOyjIwqi7aHkGq/iaD1gl2jZS+aSIMz+uiA0V8Dqu4ruC4sa19uBfgmfFMzEQ=@vger.kernel.org
X-Gm-Message-State: AFuF++ndmjFY6PWDfR98I8DLD+ImgcXxxo/GSokALrw2wdlTFXo1wxuZ
	1XnEYlGlFbZKNCZz+rK5vVJnOyn+rlRwJuSGw5iRvjgryiMqFuiWcYoC
X-Gm-Gg: AYBFou31PqyJg0L+Z3Xi+f6CZ1u/FOJfzuV+TepJSrCE+axjCNfZ6HFET9FKFAa4wl7
	65xkQYdS/FMwoCde9WuGfKvskDhx6tDOZWMJW83woHDf90nbHmVUZEsQUwaOcn0cN20mYX7sJWG
	nCToMB9m+a2o0FtH2VBWTXWBURJ+fc58VcUe0LbewBYcw2+LBWd2ZoyPdMnO4WSN+P3ElkQrP2h
	/yvcZC5w2TT9olycGffE3P/8Xjwc+tqFDe5FTGTbwDkeC954J0D1L11OrY9gTAq50vaaBjZKmFk
	VolzTBNCoDJW2FlDaQP9seOZctp2DGIdswyCDI0PIu/h2E6gkNDDcsrQxTgqVt07mRgTATgyAjo
	iRrzNsD/vm2Sd1kv/2YCl+j54nohCQed129mBn71vxcpJcvucxoQe1DfG/RIGngsLIZ14tPd+Mi
	nZue3wvgL+Zz6OhBu9fud/sHfSwsjG5ZDdVlXuRLbh5cQRywOBDyKWRW6X4gWDyDHQq7qVbmEKo
	4gFrEcJbcC7QMme3H3795F32nBBPZx9Gd5qVrMPpET5v5Y+8rgJxkBlnsbOcS2lMuUi8YMi+gVT
	dREHiw==
X-Received: by 2002:a05:600c:698d:b0:49d:1842:f001 with SMTP id 5b1f17b1804b1-4a1680e5865mr7295435e9.14.1790972924299;
        Fri, 02 Oct 2026 13:28:44 -0700 (PDT)
Received: from arch ([37.142.150.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280c84a9sm97832585e9.10.2026.10.02.13.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 13:28:43 -0700 (PDT)
From: Aviv Vaknin <vaknins33@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Bradley Morgan <brads@mainlining.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] pid_namespace: make zap_pid_ns_processes() freezable
Date: Fri,  2 Oct 2026 23:28:41 +0300
Message-ID: <20261002202841.3434087-1-vaknins33@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <CAJZ5v0jQgroKLxnyeKLedZvc9f7k0OLhHAwpHjvWK1E1BHDq2A@mail.gmail.com>
References: <CAJZ5v0jQgroKLxnyeKLedZvc9f7k0OLhHAwpHjvWK1E1BHDq2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Oct 2, 2026 at 8:13 PM Rafael J. Wysocki (Intel) <rafael@kernel.org> wrote:
> Yes, it looks simpler and it should actually work.
>
> Aviv, what do you think?

Agreed, it's simpler and avoids the extra try_to_freeze(). I've sent v2
with that change and without the comments:

https://lore.kernel.org/r/20261002202820.3433318-1-vaknins33@gmail.com

Thanks Oleg and Rafael for the review.

Aviv
