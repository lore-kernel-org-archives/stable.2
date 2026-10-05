Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318CA48C3E5
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 13:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208088; cv=none; b=gyeOxZj1+G22goWcs2vLfFKb1Gh1yenSf3ymnVCggpHeRLhKUvTTy/MAFfNRZeJ80zKmpyRxVSaDpDvDhKhnTyHWkg+JG7NNt2g5acFYTo09dQUs06qIlbUxvpzlBHZsNsv5BAVSMUd4Qg77K1h5E2FnXORTp9JDX+y0EUM/S/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208088; c=relaxed/simple;
	bh=41lGeLEVHX8B9RzhR8lhkSJeirJC2VDxme0firoTTZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oHr9Kzw125oIZd41INHmvDW2LV+2rPql304lKW2wCD3N3vqsAv5h49zpPxNCtqAg9RNvlgZhOJgxwqth3iFVMMe8+K4iC0h5wKMa2/kpsaaSx3Irm71DDYQqtjGU+UIrarg7f4sDhMmbiRDyZ9rvTUjf3pqhLJaQYX8UnEBqXww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGIzk8N/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGIzk8N/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D188A1F00893;
	Mon,  5 Oct 2026 13:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791208087;
	bh=KI8EkzUdrZ4sOUmopiU74htwTbgtq0ZrQ2CRAZ7VPa0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QGIzk8N/XFGh50RAphRaGQGqINN+UKhEkLc6XyKis3B5ptG4fZ2lW/PHuXVuP1E2n
	 BHddCKmutTW9NxgTT4Egrexs/mEpZNkhw9F5xsQoEiQvxx9vxUyb/a5AByvbZoJ9Ar
	 A5krPfjLMJdxdenKhD8gmWr4wWNKBQDRbicmchxhfO8yYwzBOZ905i+mh/8PTSJfYI
	 13G8WpOkiy45YYYDcGxLUNyDT2i5bgLzVVr2n+lNRXw/ZiVlQ8GXBQcE4X3UT3KiI6
	 tmbUPGNVTK65SDQsv3ybHK7g9pl4BydpuLACZxqiGsAuUzmjHTf7wW7jUxRxkITB6T
	 dAezbnziuCsUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Francisco=20Beltr=C3=A1n=20Millal=C3=A9n?= <fbeltranmillalen@gmail.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] drm/amdgpu: reset VI ASIC on MacBookPro14,3
Date: Mon,  5 Oct 2026 09:48:01 -0400
Message-ID: <20261005134747.2967537-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005134747.2967537-1-sashal@kernel.org>
References: <2026100527-zealous-puzzling-af30@gregkh>
 <20261005134747.2967537-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Francisco Beltrán Millalén <fbeltranmillalen@gmail.com>

[ Upstream commit a22e5e4f2ebbdbb962cc3233094d189c4dfaa051 ]

On a MacBookPro14,3 with a Radeon Pro 555 (Polaris11), the framebuffer
is at MC address 0 when amdgpu loads after a cold boot, as the firmware
leaves it (MC_VM_FB_LOCATION = 0x007f0000), while the VBIOS ASIC_Init
table places it at 0xF4_0000_0000 (0xf47ff400).  amdgpu reads the
location once, at init, so after a re-POST (S3 resume or GPU reset)
the framebuffer has moved and the driver keeps programming the old
one: the SMU is handed a table that was never written and the GPU
does not come back, which leaves the internal panel black.

Resetting the ASIC on load makes ASIC_Init run before the driver reads
the location, so the driver uses the VBIOS placement from the start and
every later re-POST puts the framebuffer back where it already is.

Add the Radeon Pro 555 used in this machine to the existing VI reset
quirk table.

Tested on a MacBookPro14,3 on 6.18.49 with the quirk table backported
(the kernel also carries unrelated local PCI and ACPI patches for this
machine).  The framebuffer is at 0x000000F400000000 after both cold and
warm boot, and the GPU survived 9 S3 cycles (lid close and rtcwake, one
of them with the lid closed for about 7.5 minutes and a USB-C disk
attached), each followed by a few minutes of 3D load; no ring timeouts
or VM faults were reported.  The reset adds about 0.23 s to amdgpu init.

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Link: https://lore.kernel.org/all/20260924132952.25054-1-fbeltranmillalen@gmail.com/
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Francisco Beltrán Millalén <fbeltranmillalen@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit b6b1d97218518003107d4446fac278fa3e0a19a0)
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/vi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 012edca8517ae..0cab98957ca40 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1418,6 +1418,7 @@ struct vi_reset_quirk {
 static const struct vi_reset_quirk vi_reset_quirks[] = {
 	{ 0x67ef, PCI_VENDOR_ID_APPLE, 0x0190, 0xe3 }, /* Radeon Pro 555X */
 	{ 0x67ef, PCI_VENDOR_ID_APPLE, 0x018f, 0xc2 }, /* Radeon Pro 560X */
+	{ 0x67ef, PCI_VENDOR_ID_APPLE, 0x017a, 0xc7 }, /* Radeon Pro 555 */
 };
 
 static bool vi_need_reset_on_init(struct amdgpu_device *adev)
-- 
2.53.0

