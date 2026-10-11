Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0322636194B;
	Sun, 11 Oct 2026 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791737347; cv=none; b=eNDRCbR6ZDSso2d9YJGy3cZ4YzeJSY2qC9onOQ5Mwc5qicYKW8rQkUhcEnoYdYYdSwCIikNsdO3zsMQmdY34mGEWlNFbPrEaoSF3AQHb7WrvczOIPBYrWl5AHmkgWEixnLNOhlNvbXSQhoW+iRG6w/2X5dLu6aoNXTAGH9gGcHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791737347; c=relaxed/simple;
	bh=wLBj4IiwvyegT5zsNdQA3tHat5t3RZwVB38uNe5jg/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u3jswQ9JeaQIDIttyMbykwUw0ge7eqjxR1DYlumd1TYOGMXGtgTjDakRcoZIxUqyVQpDdG+cLd32VxbVSa102bmyc6eBjAfYu32pUPEOpbhksJ2g0yJ76WttObtANsO4LkiEsuCkQRCYHvNkqbtf/onlRJ3jBzVHEg3ta6OgVLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hdw71Kfx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hdw71Kfx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD4F1F0089D;
	Sun, 11 Oct 2026 16:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791737334;
	bh=J3hxxeSmfa7hMOUSxbRHkBwhdk5RHitOI+8eCdNRVpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hdw71Kfxeefo8ZUovVBmWtsR2AwVoCi/kRVKUTMsm+zRL/hA7THmf7/cgYUOjzzuh
	 PZaJ5EIkZSofXWWnPKILzQKfUBgNNpAokY18OAbGkrdeAubW6wPPHClHKRLrSMj35Q
	 IWZK+NWbGKoZxM/cJEjP5MKnKfNSfHh3J74V/YJIi+vykrDrJsA9EqhmD2riYdoV80
	 qIddunbeVeLNa+Tf0SOGuBuDwvIGtw4exisDRpYy1I8V/RDQ1yZgn7rs0DO20bjZ3z
	 QcIxV4WTJhnSMvBhFBw5CmueBqn7DNhEX+QAHdnHkEuwkQFX0zSlqs098UTE0mBBrd
	 ng1/+Zr5h6RCA==
From: Sasha Levin <sashal@kernel.org>
To: lee@kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	David Rheinsberg <david.rheinsberg@gmail.com>,
	Douglas Anderson <dianders@chromium.org>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Ai Chao <aichao@kylinos.cn>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>,
	Jiri Kosina <jkosina@suse.com>
Subject: Re: [STABLE v5.15-v5.10 1/2] HID: core: introduce hid_safe_input_report()
Date: Sun, 11 Oct 2026 12:48:26 -0400
Message-ID: <2026-10-11-1-daily-reply-0019-hid-safe-input-report-5-15-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261011103912.2201634-1-lee@kernel.org>
References: <20261011103912.2201634-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> hid_input_report() is used in too many places to have a commit that
> doesn't cross subsystem borders. Instead of changing the API, introduce
> a new one when things matters in the transport layers:

Queued the series for 5.15 and 5.10, thanks. Patch 2/2 needed a context
tweak for 5.10, which has no READ_ONCE() on ->running in uhid.

-- 
Thanks,
Sasha
