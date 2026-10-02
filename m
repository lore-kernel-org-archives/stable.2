Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDB03F1ADE
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 19:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790968526; cv=none; b=ldqI7Rb6lsxi7kSc9F5KT4PVqDKtDxvyOxi8LcK41XivlX9N9atF+Ud+8zdatVzlEGCVk1ilxZyFhNQlcICRAnhejQU68/djOKASMMwXsB7npdT6ktCetN5tUCROATv3eJhr3JUhScVWbsGy7bzM9jQJvtZ87BqrjVwvm/iNIqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790968526; c=relaxed/simple;
	bh=0v6EsoR5T+lucdH/eGhXBeOr7Ze3sxH1Mqvmwg12+vs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egmkr1y6X+ioCvpSMDXA6O8JlQZnZMxcAJyJn0xKJobHUi/TZYCxHOjbREagsZOEUV+Mactyhzqk2RY1PzYLE7gVkR04VaZRRvjDoj9irqPgygBUXY2UBUuv+3sKeYfaWDs5v6CNTqfPRtIiAUgOMCF6QBxQ9vBuaLyGbbYut/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F73AVCVu; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F73AVCVu"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a022e9cbebso1858235e9.0
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 12:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790968523; x=1791573323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Z3J1wTRaL7AOg2V1HNOvyAPEeXuGFQq5prc0aUbI2M=;
        b=F73AVCVu+7ekD5xjlNRVXCf/At7gGzEk2sS8qEW27lgLP+Lepaf4HMCowjrl31qP15
         pPLDpPn2uaEt9l7MzvjsbfThWNQYq8FX9BUUffTeL3544vNN6hv8QP29Tmb8eAMWrjXi
         Ozd40c7GpMdsujsUeACMXZunzO24m1+au59VeY/ZcjSqv/5hy9FDMfy7+nHHMrFhHK7I
         yk7TpXtJxsH963KGgZEfLa5JUUDLu89WhBLGD2Of8ytq9zAL3oPFSA7drpqQ4edm9c42
         g4J8H/CuAlBt/Cd4x0upT8qrQdrGsFpABAaMeXtogh9FuMNBtTs+qWU4zdCUBbBmEsB5
         U4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790968523; x=1791573323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1Z3J1wTRaL7AOg2V1HNOvyAPEeXuGFQq5prc0aUbI2M=;
        b=AnkEzB/ygtRHdspOYVytm9qqNxAThc+CBTtlaNHyBEd/ikt+WBkBFxCScd1sa9Vagv
         fgFYOyoa+EAsMHySxx2v7nuxR27YET+dpxY6CRgWWuyHybYUqK54i2jcNedxmDM1tsR1
         0szQM4Nk4i3u3+20v/9UopPU4swnYzQHWTDuioJQjFyxME/q8qjXsm/PcmL/w87cn4AS
         pSW7F8H0QQv+6D7021hqXX7c71NupwdzHmrhT7iS2jmvwarsS6QX5vZRH/rifVOSgxh9
         weSch78CxdACab19vLTE5BI8hjHIA6ag1xjVmH9UqyC2VPIAfi/BD7Z/K941vDV3Ajc1
         Ch4g==
X-Forwarded-Encrypted: i=1; AKwUvBxCRkpzVdek+cNEooZ9yAyH70EYrIDEv7iVKyd863JN6GFyTI0eKs5WLEJCiKsOtFCI9tTAUpA=@vger.kernel.org
X-Gm-Message-State: AFuF++mc9FFANzXfNFVoI4jHuP8hAAzZ8tcA8MqXkOLeYMJIIgVxMSVw
	Sv7DgFStw8sm79xp6cZFOTj7Oz6hhblTS8W7IxNQ2b7e7pIm27lGS/qeoiPIW3JuqTA=
X-Gm-Gg: AYBFou3VEgr9tdgLvC/JOl74399uXeKrCp8pAjxNyjSTWeDxZJ13l2lyyJvaI2XGf74
	BCGOZipKPN0DGi2Fq3i0PXZ3lUrsYpMAJinJuT/qmbPlDm7Y+ZwEvcTKXJPGwbWLLhoUAOuqkEN
	6aDHUeEUIRsmvuMkauClat5ZpMrhMWWxkTqaBnfsX/Y9cckxP6DF8rlaNeyOVMU0ukAzREHZfZ6
	zZhH2MyfTMExbQUesZHXx3ycsZR88gforwoVQ0dMqbnfd9R2sue7fqSR9pKbBy3kKflEnh7Rq22
	9B2zqv9IxlaHb6yA45gwdjbVxE0btZoiITwE0igg6luG8+qsE+zbTFiOtaWotu19SZb3es8Nz8C
	7oogXaAEdF4aY0C0CaIJ0oa00+tmwLlOy+q+RURVSSMRdK5Jrf3iKAVxXBD6z8KctryNlj5YJkS
	aNrCey4EvpnyC+LuYC8St5CcUITpprpHsMWcvz45JihSjdfOLke1G3Fy8WCuxMixif7U/9YJa3Q
	H1e6tiPV/WvSRmu5vJhUEk/gsEciaJL0hVYnxpPOveKGTizP967
X-Received: by 2002:a05:600c:3b01:b0:49f:dd9f:6038 with SMTP id 5b1f17b1804b1-4a027573634mr54711305e9.25.1790968523131;
        Fri, 02 Oct 2026 12:15:23 -0700 (PDT)
Received: from fedora ([202.47.63.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0e1afbc44sm81151145e9.4.2026.10.02.12.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 12:15:22 -0700 (PDT)
From: Muhammad Bilal <meatuni001@gmail.com>
To: Jorge Lopez <jorge.lopez2@hp.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muhammad Bilal <meatuni001@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 9/9] platform/x86: hp-bioscfg: fix oops on short integer attribute buffer
Date: Sat,  3 Oct 2026 00:14:34 +0500
Message-ID: <20261002191434.58529-10-meatuni001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002191434.58529-1-meatuni001@gmail.com>
References: <20261002191434.58529-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hp_populate_integer_elements_from_buffer() ignores the return value of
hp_get_string_from_buffer(). When fewer than 2 bytes are left in the
buffer, dst_size is 0, kcalloc() returns ZERO_SIZE_PTR and
hp_get_string_from_buffer() fails without writing to it, so
kstrtoint() faults on address 0x10.

Return the error instead.

Compile tested only.

Fixes: 6f2c06d5a467 ("platform/x86: hp-bioscfg: int-attributes")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
Changes in v4:
 - New patch

 drivers/platform/x86/hp/hp-bioscfg/int-attributes.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c b/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
index a27907066..14317b7fd 100644
--- a/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
+++ b/drivers/platform/x86/hp/hp-bioscfg/int-attributes.c
@@ -331,7 +331,12 @@ static int hp_populate_integer_elements_from_buffer(u8 *buffer_ptr, u32 *buffer_
 	// VALUE:
 	integer_data->current_value = 0;
 
-	hp_get_string_from_buffer(&buffer_ptr, buffer_size, dst, dst_size);
+	ret = hp_get_string_from_buffer(&buffer_ptr, buffer_size, dst, dst_size);
+	if (ret < 0) {
+		kfree(dst);
+		return ret;
+	}
+
 	ret = kstrtoint(dst, 10, &integer_data->current_value);
 	if (ret)
 		pr_warn("Unable to convert string to integer: %s\n", dst);
-- 
2.43.0

