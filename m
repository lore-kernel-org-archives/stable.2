Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9873AA9F4
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 18:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786646669; cv=none; b=b8esorVLlXWNIfN3XmJk/kH/77lYfms+/NeFJHPH0actIl1ueg6yxgyDeg4ylMLnHNncySiETDWnsBCBQcojENPD8dnLpKbpWJcK4FOGFcHTeNBoMdgLr6JoRykytyosjuuRwtbkrPj/LD48pAhnz9F7QxE4nAm7cka+GdY+GqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786646669; c=relaxed/simple;
	bh=8OjxNhHePidmg1fuKU7xo+rrS9JcoHVOhiq3oQjVaNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bb50r2aXWiEjyJR5wa+DLX/5S06RaIR+EEUFDwDj17EhpMcAanYZ6WDDGKHJiL2H8Vxca1YmqFYrnMIZKfRqxXWaJtGPItrzN3ydXENUylzmpNgorKgoBGPlYS1oJpxN8CbPS86ZpuN2M1sM0UD+CNOf3tRE0t4fR5aTwZ4hMSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FniQsQLY; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FniQsQLY"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39dbe684115so10080061fa.1
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 11:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786646666; x=1787251466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8OjxNhHePidmg1fuKU7xo+rrS9JcoHVOhiq3oQjVaNA=;
        b=FniQsQLYwhWoN1mHzIYGxvJ4jGTnURfb4d/1cKpQ+viAK3QQQXrgdj5Enj1470qDl5
         Xhw1ZEqorPiqYbVrlp8UALQ+Dtl+pClo14Kbl4C4iWHW6BT6t/nxIGMAgsfCTjZ9Fr1C
         vYYAWSuiHa3ThCxoysvbGJXUDBGZep3V/jo4B+sG6fpREdRbXL6Kbiv42EFNo92OLzlV
         1Fzs+ZjJ1NyjV/5o+lRtQjGf2W16KMz5wit57/UH0GrV7YPx0Pxb9kFb2zWkct20RVZ4
         Eecn+9dRpUFjR+QigUd0BqaVtG4zUZfJKxgpgpCpT0dOJy1HD32qosafhiC47v4isduQ
         +kCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786646666; x=1787251466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8OjxNhHePidmg1fuKU7xo+rrS9JcoHVOhiq3oQjVaNA=;
        b=rijkOnHBv4O2riiGYRNP8+G4NpQ4b8JcxBbCJTq4zwGaVV5dr3zVczz12zzBIVR7o+
         L4HUce5twudj/0pnJJ2+O9vVVANdrHJeMlUJn8ocd86wkql6/XkPIFG19OZZFJACtb9I
         z9+Wqco8v8VK8OfGXs6M6oHgWFf/Np7rextkYbM1cOX1OoNGzFjMOA8DEt9fcsoEogK2
         RYP0a5/fpwRIe9gNLV17IQt9bpMjkW0oOTiDzMN+5BwWuOpjuwjHQuGPKulG/EDULdEu
         RjabmmkU9+lGsQtEGOUFykhX632LOBZCR3OmO874tz5LdcRVCQT3dgVTQjtV+lzyjjFP
         fm/A==
X-Forwarded-Encrypted: i=1; AHgh+RrV8/uLlMkZznyDQ1xkouTrYrR35xXCrNwRRiLbnMTmTMo4aeJuT54jSqKK76fMQq6K5uYwoPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBfl8VSeu5MYD6bpz44tfed45hqC+DoauWhzbir3V+zP4OBF0v
	FqvLueqQKIv1dNgTjKkXKQ0gQ2eWq2iyG1RcgE9yDStRHcQ4zntNAo4w
X-Gm-Gg: AR+sD108OOOztvzJabjDEDnOSeVypjX5pNLX08QDiJj3Ik8REL25jkw+zK9qZ9IP7Mj
	Nmbm5O4TUh5v7W89b8czJ3VLS83qF2FAaz2m4wZwF6DKmav0h0JS4pxYP7cU+Rx5qRzGbDHKCT9
	wckrqZHLNt3Vu7VD2/bfArskB1YZ+IxwC/V51H31YIY9ntgR4KM6ZslVod8i1LuPus/PNTa+ydP
	Ov619plW+KTwmJakBPKN7uMO21z/9d1TEcO326xxHHedNvyPRnkZRTs/K6eWMAnjq2snyYf4ZvT
	mpLhWqiE2iCUiLjzOQCu3P0oN0gqwcmwqyXtwDmWFP2moe5s2f0hM/6l4ssdJcASjy6RP2r7Nxd
	FB4mQbLCOkxOCrnfyFiKpHWeuUK5bS4qj3e3j+mwhEBUefN/CYHkd0BL6bmJ6LbEldjI7EwcDeT
	J3xMERm0yPmItW4wB8xm5wjD38Nw9fIB64jmh7+h86fvEvuOn71c9a1rc2+NcCTjIp2myB2C1En
	/0cs4K7ULEI/dG0R931tM9kVrRVs3VC95B9oSwiBMsNlwO+8uPx
X-Received: by 2002:a2e:bd12:0:b0:39f:af21:75d7 with SMTP id 38308e7fff4ca-3a11b9206d7mr11997201fa.2.1786646665697;
        Thu, 13 Aug 2026 11:44:25 -0700 (PDT)
Received: from XPS-15.tail097737.ts.net ([178.81.193.36])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a130cfa1dcsm1187621fa.28.2026.08.13.11.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 11:44:24 -0700 (PDT)
From: rafayahmed317 <ahmedrafay888@gmail.com>
X-Google-Original-From: rafayahmed317 <85213825+rafayahmed317@users.noreply.github.com>
To: sven@kernel.org
Cc: asahi@lists.linux.dev,
	gregkh@linuxfoundation.org,
	heikki.krogerus@linux.intel.com,
	j@jannau.net,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	neal@gompa.dev,
	stable@vger.kernel.org,
	Rafay <ahmedrafay888@gmail.com>
Subject: Re: [PATCH] usb: typec: tipd: fix VDO handling
Date: Thu, 13 Aug 2026 21:43:13 +0300
Message-ID: <20260813184313.405826-1-85213825+rafayahmed317@users.noreply.github.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813-b4-tipd-vdo-fix-v1-1-70317f2cd554@kernel.org>
References: <20260813-b4-tipd-vdo-fix-v1-1-70317f2cd554@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tested-by: Rafay <ahmedrafay888@gmail.com>
