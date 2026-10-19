Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792422185;
	b=CaU6nK7BVBvVdR7tS009uWcAw18ogdT/uWye7NAJJ9xPgvlVpVOHvISah8Fxzc3k+gkT
	 pc1O7a9Y53VrJPYW3nR/+xgwKZKWHZtM6VsX7+fpNu6k25xa87Gr9RJAe8cGbnPYCjlSO
	 DIarEKVQov9X15gez2SZGx6HWZkqkaSamMCTy1VbV6egS/fpHrNcV0PVTHPS6EHhYjFhH
	 iJx6fSnbskIU9fHMlran9pDsh9DBDyUSk/bRomyisHHMZMsci9lJDg4S32UrUbhET6wwx
	 5UltulIcBXiVm8iKAQIgUvdZ5JyMaD2/ipQq9WRwcH6L8x71DGBmq/CggDv0i6DNaeA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792422185;
	h=DMARC-Filter:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=gdV1/O4VikiEnDXhx+wtFAmuRIIeqYAzhACAoR8M6JU=;
	b=zpPXs7z3FNtplHZhTszUseIPJLYOoLhZnBTrxgOokBZ5VqoLXoXB2gecMOrc5ZDQsTMz
	 mvsmdVCor72MaPkiKLO23yct/Rbs48spMJe+MjqKOSaZq77DVPoVXSzpBbjhh0fZ7cTCC
	 g5QUh/BSeD53U72F3OHpBOSd97FYvtVJWvFPP9qdFqKe6fdRq9JidaIPu/PXVYddu5326
	 3quZUbLZfY6dj+GwJ7Ype128LvyUgE9+wH2/H/6epRQHigE9sJtd69+bdb4AXE5uDa8C3
	 EyDBn4irAlh34dIjvuIu6WwapIv+oFSuM73a2qGWigZ9+2bGPKtv9gki6A3gJAyrXNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=i@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=KeApZt43;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159C1607D348;
	Mon, 19 Oct 2026 15:03:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 159C1607D348
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rong.moe header.i=i@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=KeApZt43
ARC-Seal: i=1; a=rsa-sha256; t=1792422171; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Rh+pwOslJDbusA1YPyVGl1mmeaeqbGqMjKGRnLlJZet76vYl3/dOkXCYP97SiG3olboOdVQkp2iuLqrA8Lpdzw5MNgNwjAErcts/a9W29ILP375kKz9HD98pFmGEbD81/zBsrUOmVDeN4FcIM63r4mbw/yHTWZ7bi1U1AhcqCYA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792422171; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gdV1/O4VikiEnDXhx+wtFAmuRIIeqYAzhACAoR8M6JU=; 
	b=HlDvSCwZ+vEw06JHv9J1UcL2orY9GCoEEfTTjJ1LcobIYyu6GSRgNNwFe3gJSobu8xbLYBpPdsPqDneOqATq/DLp8emZ5JZ8LlrIj2rA9Ek1udqOzo+WXq06+faCIBZP6/Q3LTHaJXsGILNDFeFPolwj7PL0obWwCWxagVOs7Is=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792422171;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=gdV1/O4VikiEnDXhx+wtFAmuRIIeqYAzhACAoR8M6JU=;
	b=KeApZt43em/Dp7Mqo5lR2WvsL9u8Ty9OjSwLFCXMkpxMeZfJeKhkDu8oycmHM87F
	A0OxSYuqiVjEvG7dHJfOCG5qxjwETkIivgY54pJ74nKjN1v7TL267+WFXW7NpffPSwD
	W2kKSasfwag0MDfxASpfL51rVJP6Wuw004EfJo0Fs/ymClb+GZYp4A8WBd1Fz8hqbUQ
	t1/jEES9MNlg6+uUvBClXNt9u0r60oOXpO3ATUAPIKVFygblSA2nydeRZ3LvMv27VpU
	vNMRde6cG7+PTq1qCPAeoss2+asyFcEP0FaIDldD6AeVNkIb9yJh2oyMkoJ1bHxe3AI
	xex94oI9wA==
Received: by smtp.zohomail.com with SMTPS id 1792422168943414.4923037319322;
	Mon, 19 Oct 2026 08:02:48 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Subject: [PATCH v5 00/12] platform/x86: lenovo-wmi-{other,capdata,helpers}:
 Improve robustness on faulty firmware
Date: Mon, 19 Oct 2026 23:02:22 +0800
Message-Id: <20261019-lwmi-wmi-new-api-v5-0-71557d28d058@rong.moe>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23OwW7DIAwG4FepOI/JOIRAT3uPqQc3MS3TmlTQ0
 k1V3n3QSVPU5eDDL/n77btIHAMnsd3cReQcUpjGEtqXjeiPNB5YhqFkQS1ocujk5+0UZJ2Rb5L
 OQfq20XrQlqwhUdg5sg9fj8r33W9O1/0H95faUzeOIV2m+P24mVXdEwhowCn9vz4rCbIjDeDRG
 +ftW5zGw+tpYlHbM/55BbDyXsbiNaBF21g0nXvyzcKv3m+KZwUN7nlQvVVPXi+9XfG6eCLPvnO
 t6TUt/DzPPx02K2GBAQAA
X-Change-ID: a504a929-lwmi-wmi-new-api-f5344d48a86a
To: Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: Charles <hanker007@gmail.com>, 
 Navon John Lukose <navonjohnlukose@gmail.com>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rong Zhang <i@rong.moe>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-6be7c
X-ZohoMailClient: External

Some devices do not support LENOVO_CAPABILITY_DATA_01 and define the
query method as a stub that returns zero buffer. Unfortunately, some
devices do not implement the stub properly, causing WMI errors
(including ACPI errors). This was reported by Charles.

The current lenovo-wmi-* implementation enforces the binding between
LENOVO_CAPABILITY_DATA_00+01 and LENOVO_OTHER_MODE because of a
limitation of the device component framework. When the capdata device
bailing out due to a WMI error, lenovo-wmi-other becomes unbound and
unable to provide firmware-attributes or hwmon/power_supply_ext devices
for the other functional capdata device.

Therefore, errors must be non-fatal in order not to break the
assumptions made by the device component framework.

Poison the capdata device by releasing the capability data list in this
case. After that, NULL list will be passed to lenovo-wmi-other on bind.
The latter will provide whatever is available, or unbind the components
if nothing is available.

A poisoned capdata device releases or skips allocating most resources,
e.g., the capability data list and the debugfs directory. The device
itself is only used to satisfy the component dependency of lenovo-wmi-
other and coordinate with the latter about the absence of the capability
data.

Meanwhile, for devices that properly stubs the WMI query method (but
still declares >0 instances), keeping the capability data list with
empty data is meaningless and causes lenovo-wmi-other to call
lwmi_cd*_get_data() to retrieve nonexistent capdata in vain. These
capdata devices are poisoned as well to save resources.

In order to release or skip allocating most resources for poisoned
devices, some preparatory work is done in prior. With the preparatory
work, it also skips allocating most resources for the WMI devices that
declare 0 instance.

Also identify missing components using the new wmidev_exists() interface
(introduced at the very beginning of the series), and skip adding them
to the match list, so that all components in the list must present,
fulfilling the binding requirement. Some devices need this because they
either do not have the WMI GUID of LENOVO_CAPABILITY_DATA_01, or do not
implement the query method, causing the WMI core not to create the
corresponding WMI device. This was reported by Navon.

The new WMI API is also adopted to conform to the behavior of the
Windows WMI-ACPI driver and improve robustness on various WMI ACPI
method implementation.

Finally, add myself as a LENOVO drivers maintainer as previously
suggested by Derek.

Reported-by: Charles <hanker007@gmail.com>
Closes: https://msgid.link/CAKtz0s8UYRQYW_0bh=0TMx47Axm-W-muEay-r3rqUBS1NHMPVw@mail.gmail.com/
Reported-by: Navon John Lukose <navonjohnlukose@gmail.com>
Closes: https://msgid.link/20260928190901.1369497-1-navonjohnlukose@gmail.com
Suggested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Link: https://msgid.link/9789f452-d7eb-4f1e-8a13-7335332193a7@app.fastmail.com
Suggested-by: Derek J. Clark <derekjohn.clark@gmail.com>
Link: https://msgid.link/782FE636-A06A-4E12-9563-786374805947@gmail.com
Signed-off-by: Rong Zhang <i@rong.moe>
---
Changes in v5:
- Move the definition of struct cd_fan_block outside of
  lwmi_cd_fan_list_alloc_cache() and rename it lwmi_cd_fan_block (thanks
  Ilpo Järvinen)
- Link to v4: https://patch.msgid.link/20261018-lwmi-wmi-new-api-v4-0-aafef7956c4a@rong.moe

Changes in v4:
- Fix typo (thanks Mark Pearson)
- Pass the error from guid_parse() to matchptr
- Link to v3: https://patch.msgid.link/20261014-lwmi-wmi-new-api-v3-0-e1032bed1c81@rong.moe

Changes in v3:
- Shorten the comments of struct lwmi_cd_priv's members (thanks Derek
  J. Clark)
- Leave struct cd_fan_block's __packed attribute as is (thanks Armin
  Wolf)
- Link to v2: https://patch.msgid.link/20261009-lwmi-wmi-new-api-v2-0-402828382679@rong.moe

Changes in v2:
- Add PATCH 1 ("platform/wmi: Introduce wmidev_exists()") to the series
  as discussed at https://msgid.link/83776200-4A60-4756-A99F-D5A3BB4D834A@rong.moe
- Add PATCH 2 ("lenovo-wmi-capdata: Do not stop the AC notifier chain on
  error") to the series, as adopting the new WMI API will intentionally
  catch more faulty firmware and propagate more errors
- Synchronize mutex initialization with release-acquire barriers (thanks
  Ilpo Järvinen)
- Refine line wrap (ditto)
- Replace the term "poison" with "stub" (ditto)
- Add PATCH 10 ("platform/x86: lenovo-wmi-capdata: Do not match missing
  components") to the series to solve the report made by Navon
- Update outdated comments, function documentations and commit messages
- Link to v1: https://patch.msgid.link/20260914-lwmi-wmi-new-api-v1-0-7a400f2f69f8@rong.moe

---
Armin Wolf (1):
      platform/wmi: Introduce wmidev_exists()

Rong Zhang (11):
      platform/x86: lenovo-wmi-capdata: Do not stop the AC notifier chain on error
      platform/x86: lenovo-wmi-capdata: Only allocate sub-master info when necessary
      platform/x86: lenovo-wmi-capdata: Store a pointer to component info
      platform/x86: lenovo-wmi-capdata: Defer mutex initialization
      platform/x86: lenovo-wmi-{capdata,other}: Only allocate capdata list when necessary
      platform/x86: lenovo-wmi-capdata: Adopt new WMI API
      platform/x86: lenovo-wmi-capdata: Register component even on WMI error
      platform/x86: lenovo-wmi-capdata: Detect stubbed capdata device
      platform/x86: lenovo-wmi-capdata: Do not match missing components
      platform/x86: lenovo-wmi-helpers: Adopt new WMI API
      MAINTAINERS: Add myself as a LENOVO drivers co-maintainer

 MAINTAINERS                               |   1 +
 drivers/platform/wmi/core.c               |  33 ++-
 drivers/platform/x86/lenovo/wmi-capdata.c | 458 ++++++++++++++++++++++--------
 drivers/platform/x86/lenovo/wmi-helpers.c |  61 ++--
 drivers/platform/x86/lenovo/wmi-other.c   |  24 +-
 include/linux/wmi.h                       |   3 +
 6 files changed, 404 insertions(+), 176 deletions(-)
---
base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
change-id: a504a929-lwmi-wmi-new-api-f5344d48a86a

Thanks,
Rong

