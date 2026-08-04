Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D03485CC3;
	Tue,  4 Aug 2026 17:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862973; cv=none; b=BU6lsLFJBZSF/Dv6geiaPO0+Ub01x0slZhm41+6OPeO6rCCbPlPmX/4iZ6lO0h7MWnzEZBspEfTLSCczSVXV4QVmZHt1G+vsgOwuxrAcnD8Uj+Nd+S2KfZyaRnjd1TYJqCSpfX0SSQo02sDQO73RfOB46fV6dz2opOIhiqC3hTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862973; c=relaxed/simple;
	bh=EE0KrGo5dDzUMJhyrwdjkIQjmw4BM9ksA8M3WP6xW4U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KPs3Ieeuox75YMhXt04+Bu8yNv0YF63XST+XXa8vd0licDKtcCSKRDoPUGvwVu2E5tpC8Cc8Iphslvj4dBjeeFLBmoNJam1lJPOUBgcx4hB/QScAsg46WTcdkkvuMKiVvuNM8gHCk8wk9eHPSu80kgwZDReWzePGcoy5TMVh8j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=q4w89P6m; arc=none smtp.client-ip=79.135.106.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="q4w89P6m"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail3; t=1785862954; x=1786122154;
	bh=2ljvQGPBoIbMVeNmgr0BUw3iuM3oikMM++hni3E8sCg=;
	h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=q4w89P6mOkWTgZIwBUCCjOFGIAmi6kbbyQ6ZlUkpKCxmIyNusjpS00JRhcs9thY8t
	 rdMrZGsYHGs1/e0M/XXHDDEsuUmSWpn905ll5cjqgXxznfPwN64SsuF8/JSE/RpOpe
	 p3a1hI2ez6VLhoGXZ9qkymwTcgCdELHgv1wc7eLrUFkEsnDEpgGEWlwPUb78mUUJ8o
	 6dMxzKZpW6mfpg/Sv8GsXve5Wmk/bj7vyLGUmFtBc/6pNIuksPVpoqsPh5Sszdx8Sz
	 n8ej1zD8SFwKoHfjh6CL9kIy3AzIUGem071o2eHc/S/XTVeSPSucUPb9zzN5aJalP3
	 Krw0yIbAmnuuA==
X-Pm-Submission-Id: 4hF0GD5hVBz1DFF2
From: Esben Haabendal <esben@geanix.com>
Subject: [PATCH v3 0/6] iio: light: ltr501: Add ltr329 support
Date: Tue, 04 Aug 2026 19:02:11 +0200
Message-Id: <20260804-liteon-ltr329-v3-0-c6b768c7c745@geanix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Nyw7CIBQFf6VhLYZLSx+u/A/jgra3FlPBAJKap
 v8u1LjQhctJzsxZiEOr0JFDthCLQTlldIR8l5FulPqCVPWRCWe8ZBUAnZRHo+nkbc4bKnNsgRd
 Q1GVJonO3OKh5653Ob3aP9oqdT5G0GJXzxj63wwBp92mLn3YAymgOA+MVEyCa4nhBqdW878yNp
 Hjgf3Ue9R5qOQiBvWzFl76u6wtCLmWa/AAAAA==
X-Change-ID: 20260711-liteon-ltr329-a3eb12414866
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nikita Travkin <nikita@trvn.ru>, 
 Maslov Dmitry <maslovdmitry@seeed.cc>, 
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785862947; l=2830;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=EE0KrGo5dDzUMJhyrwdjkIQjmw4BM9ksA8M3WP6xW4U=;
 b=drKNlsZ3FLE6ojd/wOF6L5LK7TvxLuQgq63ddEHuZfevpWbX2cknQQApFUXf9ezDzV/xUdc9x
 aFG+4I6yHwLC9yjDqVK7D2y0CLOdEss4yQTqBHkWKweAgLxc605NTKm
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

The LiteON LTR-329ALS-01 chip is similar to the LTR-303ALS-01, except for
interrupt support and related registers, which LTR-329ALS-01 does not have.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
Changes in v3:
- Removed duplicated error message on devm_request_threaded_irq() failure.
- Added Fixes: and Cc: stable tags to fix for error handling of
  devm_request_threaded_irq() failure.
- Added no_irq_support boolean to simplify checking for chip irq support.
- Moved check for no_irq_support from ltr501_read_intr_prst() and
  ltr501_write_intr_prst() to callers. Note: event functions are not
  registered for no_irq_support devices.
- Moved #include <linux/array_size.h> into its place according to
  alphabetical sorting order (although the rest is not really wel sorted).
- Restored alphanumerical ordering of compatible list in bindings
  documentation.
- Ordered device arrays and enum values according to alphanumerical sorting
  order.
- Link to v2: https://patch.msgid.link/20260715-liteon-ltr329-v2-0-d18af55edab5@geanix.com

Changes in v2:
- Fixed error handling when irq is defined for a chip that does not support
  irq, powering the chip down again.
- Added simlar fix to error handling of devm_request_threaded_irq() error
  handling, powering the chip down again on failure.
- Added explicit #include <linux/array_size.h>.
- Link to v1: https://patch.msgid.link/20260715-liteon-ltr329-v1-0-31f027051594@geanix.com

To: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Nikita Travkin <nikita@trvn.ru>
To: Maslov Dmitry <maslovdmitry@seeed.cc>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-iio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

---
Esben Haabendal (6):
      dt-bindings: iio: light: ltr501: Sort compatible enum array
      dt-bindings: iio: light: ltr501: Add missing ltr303 compatible
      dt-bindings: iio: light: ltr501: Add ltr329 compatible
      iio: light: ltr501: Power down chip if request irq fails
      iio: light: ltr501: Add ltr329 driver support
      iio: light: ltr501: Fix sorting order of device arrays

 .../bindings/iio/light/liteon,ltr501.yaml          |   4 +-
 drivers/iio/light/ltr501.c                         | 117 +++++++++++++--------
 2 files changed, 78 insertions(+), 43 deletions(-)
---
base-commit: 075b74841bd0065a3bda3440873c747938e69b68
change-id: 20260711-liteon-ltr329-a3eb12414866

Best regards,
--  
Esben Haabendal <esben@geanix.com>

