Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CFD3DD526;
	Fri,  9 Oct 2026 12:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791550476; cv=pass; b=RpjaAYHkOT9aMdXK2As75BBeqhvg0KCzwOllWM8/P2AezhzyS+XO4y0k1xdwXUQzhNf1Ed4v1a0y9QPuG+vSKw0opo7lvoo+HSnb9K7C3fHbtEo6RK+y81Ameme+Kzl5e7H4C82+D7/mrYJqB0VUmIWABQOnAWnaZ1hcqUSPgcE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791550476; c=relaxed/simple;
	bh=kZA186NM8bzB3JjeswRQZNYm7ql9pSnNlxTMKmjCFdI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hAS2E9XgamB3mZV6tbpHSL9umx0hVLtSlNOXrCy3blddK+w9Kp+hQQAHAv5doqo/tKrhSoXpkF1TPM+wAFaTWqytAl0T9v/wuOUkXI4mRvHo4HM0j82SHOyNyV3U07aCEUYqulWEOweGTdtwKV9V9h2f1kgJ9+SMjwZS4LuwwRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=KTm2PQh9; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="KTm2PQh9"
ARC-Seal: i=1; a=rsa-sha256; t=1791550459; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=noNgANQeCzsCMA6oxDHowyCjqq50/4WTstjwkT1fP9ebSR/Nen9eUP7BsDxQamsWDUxfgvh/51xJF9DvvFvthDCVVgjjc79t6LV+41IYkhWuLWWb/4tujRvIL3y78+tShRnfB10gk/mEmsm0XRHuzSAqcvmWE6dSXswqzmAcCUQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1791550459; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=uvi+z0WjgRMy/x/Q49prELXHjobVJyKj+lHliZWCHbM=; 
	b=Po868LdJt0+EKhkZI1OgBMiuGd1i8qWfeqqJiV4HD6XcZnJvfFkXyh6O2VH6utLzKXr+Y31pS0ZyuFmdonDMErkVOSRffTZLm7PsVbJ4tulJ9VcIk4/6eD2vpGUQlMboloVKM0JEy3NZnNOj7XeMOUmZU+JEenqD610Fn9COk2Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791550459;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=uvi+z0WjgRMy/x/Q49prELXHjobVJyKj+lHliZWCHbM=;
	b=KTm2PQh9fRaoIEbOIOtsA62Q3s9V95Fm+ZjT2BoGjHZH58lPKoJmOe39jBzYSWmc
	b55VTc4gS/XFtSsxDflx2r/fxdfgrGm71OcLGL3sdgj21NOPxUkMzeHxxG6DC1bBCnv
	5AQZ0wNiQHO92ToiEt1waHFtQBKHewv1YPtCuy+7H66H82PhAHBnHSLX/pUbREpPUJm
	UiAFBxyM+nz93lF5V8NOO+QdjhJW4y4eWVsNP8XG6mRQeIoV+DcW1763+QMlPNOW8Mn
	2lTzrcwGiV9vtPxnTugKsv4ZfDyT0fKdv3XKR7AdIQPuVH9aYhlwc1aQi7glEz4BAkW
	Av2c/P7gCA==
Received: by smtp.zohomail.com with SMTPS id 1791550459027831.9862036035812;
	Fri, 9 Oct 2026 05:54:19 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
Subject: [PATCH v2 00/12] platform/x86: lenovo-wmi-{other,capdata,helpers}:
 Improve robustness on faulty firmware
Date: Fri, 09 Oct 2026 20:53:42 +0800
Message-Id: <20261009-lwmi-wmi-new-api-v2-0-402828382679@rong.moe>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNQQ6CMBREr0L+2ppSC1JX3sOwqPAL30hLWgQN6
 d2luHQxi5fMvFkhoCcMcMlW8DhTIGc3EIcMml7bDhm1G4MuuNRKKPZcBmIpFhemR2KmOEnZykp
 XpYZtNno09N6Vt/rH4XV/YDMlT2r0FCbnP/vnnKceCC5KrnL5r59zxtlZS86NMKUy1dU72x0Hh
 1DHGL/YUoxhwQAAAA==
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
X-Mailer: b4 0.17-dev-73bef
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
 drivers/platform/x86/lenovo/wmi-capdata.c | 450 ++++++++++++++++++++++--------
 drivers/platform/x86/lenovo/wmi-helpers.c |  61 ++--
 drivers/platform/x86/lenovo/wmi-other.c   |  24 +-
 include/linux/wmi.h                       |   3 +
 6 files changed, 400 insertions(+), 172 deletions(-)
---
base-commit: af32da41b0327b9c6a37856ba82b6760d6c8d10e
change-id: a504a929-lwmi-wmi-new-api-f5344d48a86a

Thanks,
Rong

