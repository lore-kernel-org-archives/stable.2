Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ABA3F54A0
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 19:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792005299; cv=none; b=Ousve9wZBPM64Zk04Gc/ChoZcTr7ingA+5hOAnPXoGEL8jRr5q8H39ZXQKmNa4lVFoXk2foJ4deCP1p5WuzQOmholK1ow7a5OyNz3sj8z3IZF5bO4k3UirpvQLB03YgT75jU5bisyfHKLht8EfS4O6bVxLXw3IUVCVh6C2kXAYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792005299; c=relaxed/simple;
	bh=FV7m1Tx7xLuG6Y0N8DNSf/MbH3xm5SYL912cdbUD3Dk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LoS3P+z0Ee1l+sAsDEQguGUvth4wmqUUAsWM9qn4QIy4lrH6P+m2LaFjiMWP8ERaFGULog4xHCrQK6QfwRlcS0bmTTxR6XHAAtq+FBVOa8qoKx+Kfbe7NcNLPP+I9mAzXWlmbddUeKtus5f8AM3yDo9eEyS9lQdt6ylRlXwrwWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=GEZrCHJt; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="GEZrCHJt"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-15dd124bbe7so262126c88.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 12:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792005298; x=1792610098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FV7m1Tx7xLuG6Y0N8DNSf/MbH3xm5SYL912cdbUD3Dk=;
        b=GEZrCHJtjjOxska6BqVeIPG3iw9eU1ulncaUapxlufhg4p4BRqoeFRjp3Jr+YDnYGK
         EFDMXbVQ0Bga2u03eMQdxpWoGwCtUbCFhDoJ4prdFFMgBWDphDEfYIfexBG4WSBCOpSm
         yto+R6xypAOX2tyOwMJeR/DSmdeRSPSr716AqK0aGVl9nplItAIeroelWg0s+UIN55OL
         cfghCosa8HFF51aOOofrQABJJk0y5jbhlBuHChOsUXMkFTpOBNmGgVn/2LTKGLjA4CYN
         aV8V2p/gD/YVDCveUaaLDBDjPgGdwFHkeR2YcnntF5zdjfVG7wqo3ojyRAeDQzuZNXZo
         LjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792005298; x=1792610098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FV7m1Tx7xLuG6Y0N8DNSf/MbH3xm5SYL912cdbUD3Dk=;
        b=yH/lARMjme7H/7rkaVlr9UpHRcxmrD1U66Q/iTsyX2RP6enFZNYv/EIVK05uRjWoy+
         FoTN+TndJI2oK8BpFTWJoMlsYxKfcFvdI9hykSOpFNzEy0d+L2Hxta85gjV2/uK28fW/
         +DcWguDG5xUE5/7IlJVy7UWRJYEacr9jCIA0m5t9T8Em8G/7+LCzcMXx2qHSzvTX9qGD
         ikFRfhUikN3xf2uMeoV6MhBz8wK5blNokt2LfSdUbHEN7ZL7LsPF3E7FuTQGLMsaQTAV
         pFg8zrKbJrXETq0Mw2TLUb8R0O0WTmUdabk8EGph4VeBpQ8/MbBDU2jmZdgWDSufCrkH
         y0kA==
X-Gm-Message-State: AFq9FYKVlCGXg+a/n8BuXR4YFqFmo5L8mSfvcm0/GeVxb8QBDE/K0ibS
	zLJ5k1oR2kinfoggtu296wFQaPMebKOtJYq1aBGWU+d6NuEHG1oyu0W1fNzrSVANyv56k7UHram
	51Yci4/fV9Q==
X-Gm-Gg: AYBFou1dN4Ea2M9rIwsJLQ5JdcqjSgtxFGpbE/AbhmdAdIwGaCiNQPkmfzmQX17d21n
	DrUX4QRYvXDFJC8Nz4VkKHmdkBl/KLleljfYIkcJMzdd06pgJeTJ95wMr117o6MtbKTnn0T9p2W
	uE8oZlRj6Bq1YAA5uVFjWMBBsSFZ0FCFQ4y2MeJbiuW0UVJdsGQUKDp9mhQFDLmz8/YDTo5Cdnv
	cqm6CXtjWF5TgIYPbxNyDe5JJ3lZz8g/A6HhginOCk7ZbEhh3v10Y/DQJlFYwulpSZnld5l3Ifj
	mwfHtvarHm9fJZTvIrAxNbnh8qgJreCFc6I80Hdl0ZsZx6HgF7H0ym8yXydCo7ymL+KYjp1fIEm
	BJaH/cpoX27n/1GsAHwpANN+SYZ0YXWVWNnRUV4LTE65lGWrvu52bpzt7JY+GquTAWabCbU2FUV
	u01tgt/wEoy3q8czbOZm53d971LKfjFtVOghBRkxM85eLh8WV5BKQy5RujlnYYki61Z1qZzcoiB
	h3VtazVYez/MXVMZNxTz8woZ1XwGg+tCjtIFURtzMSGufysVgjSjxBznTJEmUAr/BBbvm4lo8Yj
	Z6S+hw==
X-Received: by 2002:a05:701a:c90a:b0:147:9ad0:cf10 with SMTP id a92af1059eb24-16a610ca3d6mr22170835c88.47.1792005297751;
        Wed, 14 Oct 2026 12:14:57 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:39d1:d8de:aae7:23dd])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-16997c21ff3sm49019099c88.2.2026.10.14.12.14.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 14 Oct 2026 12:14:56 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: abdun.nihaal@gmail.com,
	christian.gromm@microchip.com,
	error27@gmail.com,
	gregkh@linuxfoundation.org,
	johan@kernel.org,
	knavaneeth786@gmail.com,
	linux-kernel@vger.kernel.org,
	parthiban.veerasooran@microchip.com
Subject: [PATCH 6.6.y 0/2] CVE-2025-71272, CVE-2026-43317: backport fix series
Date: Wed, 14 Oct 2026 15:14:50 -0400
Message-ID: <20261014191452.23814-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Please consider this backport series for CVE-2025-71272, CVE-2026-43317 to
6.6.y.

Apply the patches in this order:
1. most: core: fix resource leak in most_register_interface error paths (fix)
2. most: core: fix leak on early registration failure (fix)

Patch 1 initializes the interface device before ID allocation and releases
the device, ID and private storage on registration failures.

Patch 2 moves callback and channel-count validation after device
initialization so those early failures also release the device. The code
changes in both patches are identical to upstream.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested only as part of a cumulative 6.6.y series: x86_64 objects
(allmodconfig, CONFIG_WERROR=y); no runtime testing.

An LLM assisted with preparing these backports.

Thanks,
Artem Dinaburg
