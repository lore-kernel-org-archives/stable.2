Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608765;
	b=g28GfXWVFZEFRuhyXl3e2KKNwKnEG8t7MLjzmA9PSbKOy8QhB/6u1VK8sXUP3AQi1Ovq
	 5nQWx3jaEKkbD26wlnT3MLiWX+c1V4ls5HCFq1ljrhrvBkADeluT6rycHVS4BM8NwpZBU
	 TKpFpeGLoKwqx2uJk8G+gJt4aKLXozc99gOeKtujZIeeHrU2kqYo+bz+wLzcHfRb1S7gL
	 1rjgqjAHO+BhAyox6KKueVpejgTtEVfS5rSLHPKMcxta58DequJ3sp3baVVRztlqbWr9O
	 V8l5T39hU7KjLLEKKzMxLgDkhDnO3HQdKs/gVXS+RVWFVlmMeZh2Gs9ehzRrG1OKj5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608765;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=//D9wA3M6w3lytBQpSdqS+hZczeIlR8TRbTjX887EP0=;
	b=YtJZU/OIq/xzj0ZB1UhlLTG1qg0OdZs8lOTY4q4hXsM6njYghL0JhYsD1A79fhaL3AgM
	 M+gWdx1jdk7ZzB3ueX3/a1/KUHgS3YfiAzpkdHK3JQUNNICUz7SYrK1sj9Mury7heVx6d
	 QMrPRC/eZ/W9IagXUeOq2xASm3SiDPREo6v6WLxRmlTM5GSgTYg55hLEycpBpEjn+lmn2
	 pPDB7FNTMocUhkxtqcUgJdcUKO77gHP8VUXModBX95af/NTY8B/9mznJPDQUefR+nJEke
	 3+3bBx8yEkJQLBYSKgrsxc659eN8ndYqKUPA3rw3AzgH/arhmkMLSxaL3caDeFc8CPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="H/Ka9WcA";
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C62606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:12:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30C62606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H/Ka9WcA
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3869f03af6aso4922609eec.1
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 04:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795608764; x=1796213564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=//D9wA3M6w3lytBQpSdqS+hZczeIlR8TRbTjX887EP0=;
        b=H/Ka9WcAjDtI2y79zLW8fBFIoxGLcCgbWbcxb8PJPteex8WBU2/NINuedxrihk15Ei
         73MZUws50LXumgmQhNyX0xXmJN5GDhQ8cFSfp9uza1qgramF1FEIVYCtBxe/QyvB13mX
         tPzXPrlJDYLw7OEK+HRXqvGjqBr3TNXom0wcD8TJLHkY+o9smXuztTDX1uvuQLi1Pm9L
         C4iS71RjkbgHSFc1+9hWh5cAxZEZT44xfpqQ3NCEQHQFM1X7wHM2hhVlV/oYHgsIqTVA
         0oXN9yPyv56Ea1KrBIqK587JgpoZC67VlFj93DBxn4rL4fzCTA+S3EWPpHDC6jPkX3Pz
         cYWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795608764; x=1796213564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=//D9wA3M6w3lytBQpSdqS+hZczeIlR8TRbTjX887EP0=;
        b=H2l3g4oDpzENCDJ8aX00xf7YS4JKJw3GH2uH3DQQoOYRZzSSHltsW3S3kL/T9AM0ZM
         w4i39RRgd1yRh/TI7Utm7Xr7bKwrinaw+P6Q0G92Zgc1x3TJm94aRNmIsORXGt2o42sE
         FykWQR1LywReRRgksN/SjCNvuAdUTBPbz/2KS6iq718OVpiKmnCInuVfwG5+szKAmgdx
         XSy5Nr0e/1mdvonR6INdcDs38Z6kqizsS5ARlhImdRsWzxyKwmlzcxZWYQ8YQi4Ua0WX
         EKeDU3Eg5urARik179wiBFhVubaEdiw9NP0J18b7RTyTHLutwGqj0QYWTzS68r7zVtKT
         fPTg==
X-Forwarded-Encrypted: i=1; AL+hErGR7PrzX4Tj9F+C3BHFOv2f7duUOgI1wyhbGnAqOsC630bY+8+nzyJbuLb7+YksWA4imbP4Ink=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ledZT6Sa85RYj+E+/+uA46hdsziKuavatX3JQNW4j/aravq4b
	nscMVJVPTnIf0hddkp4sNlMj8dmPzUSK4sIhfELRT4jeEHv+J9LrTPxB
X-Gm-Gg: AZFdTZcF8Q2qpqUb0ERK0omWr2TQUj1U5v0pqE7bQqHVjlzeaUS61iWr3enQhE8UD5s
	wjZ6DtmxJApBSb2BHvpx4lxdrokhVECqw7d+eT14c5RDZk2rGhNSR2szNQmFusiG6fZs62ckOF/
	fB5kOfB0HfiOc7rZU7AIFsa3lDy007mZD8uGKeythb6PWayvcK8n131hVlu2WIbc7HaEZGAAm9C
	vVJRTZ1grHC63OOYEpmOlzRypzIbK/C71Z5UKjSeMLkY9mtGO+XkD87VMOWgqehSXe5aAj9a80A
	P70XRT6+gkx4e0yYfUEzUMRmovh0cRHvGDF4NfoLhCTa9MbpTqZyoCGkJb2gYzxoG0CXB96LCgx
	SMZAoplBukKp+SBFVDTVbBQLw2aGjA4hfNI6Cu9PSYpH1W5s8eaHShcFAJ+VFw/DcODwELDtZY4
	FYBWz4H1ErEi/BZTm/WStdZcp5QgQX03qz2sUa2vCK09OuylZM1fVs1bYs+vNgdOVgmnwmq0rmA
	dLOpRCWQZlzdFmjFGh0RvdaATV9aBTea9R6aYAzyQBrd0NyMpes3M/OIlkbTpLx63otMZTnm1Vc
	Zj8ydqIF6rkZsyjiTUNgHau98+dszTqfzyN4hcDYVgM5o1fO/HsDjQ==
X-Received: by 2002:a05:7301:1a85:b0:36a:79cd:12df with SMTP id 5a478bee46e88-3856fe5ae43mr19541708eec.9.1795608764148;
        Wed, 25 Nov 2026 04:12:44 -0800 (PST)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386c7c62a91sm12234336eec.17.2026.11.25.04.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 04:12:43 -0800 (PST)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Clemens Ladisch <clemens@ladisch.de>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/3] ALSA: bebob/oxfw: bound AV/C response walks to the response length
Date: Wed, 25 Nov 2026 20:12:35 +0800
Message-Id: <20261125121238.1602172-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The BeBoB and OXFW drivers walk three AV/C responses by counts that the
device puts into the response. None of the walks is checked against the
length of the response. A count that is too large reads past the
response buffer, or later past a stored copy of the format.

Each patch rejects such a response with -EIO. A complete response is
handled as before. The formats in the Griffin FireWave dump at [1] pass
the new check. I found no such dump of a BeBoB device.

Found with a CodeQL-based static analysis tool that we are developing.
Each case was reproduced in a userspace harness under AddressSanitizer.
Not tested on hardware. Compile-tested with W=1 on next-20261116.

I used an LLM to help write the harnesses and these patches.

[1] https://lore.kernel.org/all/543FD6AA.5080004@sakamocchi.jp/

Maoyi Xie (3):
  ALSA: bebob: bound the channel position walk to the response length
  ALSA: bebob: bound the stream format entries to the response length
  ALSA: oxfw: bound the stream format entries to the response length

 sound/firewire/bebob/bebob.h         |  2 +-
 sound/firewire/bebob/bebob_command.c |  5 +++--
 sound/firewire/bebob/bebob_stream.c  | 15 +++++++++++++--
 sound/firewire/oxfw/oxfw-stream.c    | 22 ++++++++++++++++++++--
 4 files changed, 37 insertions(+), 7 deletions(-)

-- 
2.34.1

