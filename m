Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637233;
	b=Cx6OEvOTbaLX73ucf3ZEO1lZk/yrCPbdHVNqSuPfkS1ZTEV3dxeeYRO4UKPr8/LjuSrn
	 F1lO83JhOYWMcgP9pHLMmlbwT7sSP9mO2Jhi65wsXpNnbi7LpuFpL+cqbbXdrwkA9/2eO
	 6CLftWq9u32Oxor/VhE+OwOANXz2JLSpVGBel0K7UpPJT/5UG7kOut0x4FuKu1zKnbvy9
	 OtHCCmT1Xry+C1rG8h9teqtGsUQQ91yvXvtEw1SBvyjwKnkLZqsxrHzJWsgpcKXi5iWz/
	 jNvmYughSUpsrtAocfPAp+F2Ar4GSb/tGxc8ixmL68ZaqajBNqb3ckz3cpmp+kCCB9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637233;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=GsT7dQdzYb//Tj58M/h2/btkEU3iSa7bdoRYGllPuSQ=;
	b=BdrG7IOA5KkamyHNFBHiHjA1GTC6GGFeY1E7YOVkbTfwS6YMS1Xop2wuob5KKsmX1z5i
	 SX1bzly26bd6mNm2NXxM+rucJXOeI9nfbpgiM6heBAzRxbCz5f/GPS9j3RsNq2ql9V7FK
	 jp5WNfWn0ecGEbaXM2J2IBr5XiJCHtahZ7czAMlvazTDd/o8ymRevmDU8vTEQG5V/+4zI
	 VzYzyBp2ZfbCrcYI5S6v4/IApNSOlf3xm1K0QAloYiuDCa8ffXs7iNp9K3yhnesOcXbg8
	 LQp9vSDeZH+21xzM5aAqMpVFr+/t72fOXURNOwuGNGMBibNeHnJo+Sqvyh6MXlwsA0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W6BBKHB9;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AE9608B068
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 16:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79AE9608B068
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W6BBKHB9
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-89d6bd67045so1539888b3a.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 08:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793637233; x=1794242033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GsT7dQdzYb//Tj58M/h2/btkEU3iSa7bdoRYGllPuSQ=;
        b=W6BBKHB9vJiG8WxW7k4wtuK2BlOJikkN63ayEZrCL00EuAJDEK2vRV5/MfcLtfngDv
         wRzcTaSTgJ6LLjETkk11WbaZENguMRaSUIuCDw9RJYCgzbFqG2+s1fx0IGh8jZdleSDO
         G4GjASaZL6DjsSw99p+1DAgp/b0sWesBFmyw5Jr2t/1V+G11OnlFA0HsCLa8CvJHa5Ac
         qZLYJ6a5b9kKKgycot19gr2AeIeP6BXj/nvOo7SwDvnHjPvhauotQarx5Sld0F/8YG9t
         lMCovZPk/0KNalCdPgmB/sgH4SW8Edz1zH9i5fQ41N+Zzn9sHhlO5SK+NJfLUZ6PqMaZ
         +Peg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793637233; x=1794242033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GsT7dQdzYb//Tj58M/h2/btkEU3iSa7bdoRYGllPuSQ=;
        b=MYxWGzI1sKwf5lUheS1oR2gvyx1ljvx+2Mcuv1Vl6aqCriER5k/aCWrxDp1L6NceqR
         or7fNoM7vzmYs7zaSoRdLaBJhWlCmN0I6L5rtpzjqTjwGMOpDHN5YEHq4dioV53KWvY7
         lAkH3Yf+aOtajAnfRECoaijBK6GSZRsFuxcFTH80QKmXN3pLdKJj8QUyAOOTHyJbeyUM
         d5VZU33jp2u+k7KSHBultq6tMi9CNtblKUMOuUT45os9mfcOd9xMEGYrTGZ7ReJ1LY8m
         oBiJ9xFPM+FenalPJiNBnGKWj2DtvNi1iJdwnYFn8WRY/gGPV3Y3RP0smyCG50zurotR
         ccyA==
X-Forwarded-Encrypted: i=1; AKwUvBw1qC/vass1hPmCxa4QAG330lXzzXXJe+W82JlX3zKrXBYvTDGKa+RshWb71wxwDmfCsxP1DCI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+doDXzsutNEr4pLrZH787O+pjpXBuK07IYMXxr4thAyg84O2L0
	cRWXjCC2VVQvBfJksGWjccvlHWJcdwOhTL6flIEOAtp0l+IjwbJZNTNe
X-Gm-Gg: AYBFou2zUgTMzwMYnYCdFJlqRgMIxEhZSF7HQ4XKfOJtuekVeST/9X5hZaYk/HqYKDF
	5KRVqFHZJwJrm5sJSMnJB34aNMpjna8/7ESu8hufp7/WTpxK715aCbnxr4lzcwqFAEZDKVO5NFt
	+ZtudRDzkyG/JaeYY0N0M2gTyXPAYHlVbC1Zuqsb7Q5l7c6UgkuPVdFK32xCgCXE+xxDmMtJMVZ
	crBioWxnDkyMxvSI5z0fx896g3OCUX8jQvQxkGTYOnEg9yZZT2dQ02mAJCIOQxJ7SvWkNj/98Um
	Q6VCaAY2n+suVBR1ropEZ5YbbJrPCoLTmEhbDD3JfF3gVbAgakfgi/VggJi1wviLXfkplQ80Lvy
	5QVr7It7IV/z6b4EWi+V63ujSqpYZSIEIWUk0QbxisZD57CNlYj0OHCBhhUY4DC2ap3AqGt156a
	6VQjYakjNck8M2HE6ggz24Lz+F/BR3rykKpk3lZdcpF4dqqmqG/E7xuk9dIIz8S+qifGstqGwvw
	jRExI7RwRnlxyW2iQJ8yto5JhXykYwJL21plRQektYtWCG3B+zZYMTOGxGAKVC1oFv9NyBDQWYZ
	dG+C2fjoCMlSJB7TX2Nw4aqr3Wl4fY9oyxiFHbzRSxynEwTkZ6tyhUgNMWS82n8meXEBSb6h89n
	Up74fuK1O4ed62NxzcYP3rO/4C4Toe7WY3hwyNlLpg9FG6DFrTEwFVDyfArh4U4gY+f2tJclm/D
	0tofentnC2Vtlaw/nljgB+wnwryGOhb7q4S7I4zlcP9qLCT0vmN+o=
X-Received: by 2002:a05:6a00:f0f:b0:8a9:b07c:7709 with SMTP id d2e1a72fcca58-8a9beb627fbmr6311911b3a.19.1793637232793;
        Mon, 02 Nov 2026 08:33:52 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada3d4092sm2184549b3a.41.2026.11.02.08.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 08:33:52 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
	David Lechner <dlechner@baylibre.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-spi@vger.kernel.org,
	Joseph CT Chan <josephctchan@google.com>,
	stable@vger.kernel.org
Subject: [PATCH 03/14] spi: spi-mux: re-apply settings after child calls spi_setup()
Date: Mon,  2 Nov 2026 16:30:12 +0000
Message-ID: <20261102163023.2574632-4-jctchan@gmail.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
In-Reply-To: <20261102163023.2574632-1-jctchan@gmail.com>
References: <20261102163023.2574632-1-jctchan@gmail.com>
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

From: Joseph CT Chan <josephctchan@google.com>

spi_mux_select() copies a child's max_speed_hz, mode and bits_per_word
into the spi-mux device and sets up the parent controller only when
the mux switches to a different child (current_cs differs). If the
child that is already selected changes its settings and calls
spi_setup(), spi_mux_setup() only calls spi_setup() on the spi-mux
device with its old settings, and current_cs still matches. The next
transfers of that child then run with the old speed and mode.

Set current_cs to SPI_MUX_NO_CS in spi_mux_setup(), so the next
transfer copies the child's settings and sets up the parent again.
spi_mux_setup() runs under the spi-mux controller's io_mutex, which the
message pump holds while a message is forwarded, so this does not race
with spi_mux_select(). The cost is one extra parent spi_setup() on the
next transfer.

Tested with KUnit (spi_mux: spi_mux_settings_lifecycle_test, added
later in this series) on ARCH=um; builds with W=1 on x86_64. Not tested
on hardware.

Assisted-by: Claude, Gemini
Fixes: e9e40543ad5b ("spi: Add generic SPI multiplexer")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph CT Chan <josephctchan@google.com>
---
 drivers/spi/spi-mux.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
index 28d7718138a5..a7ea6585b374 100644
--- a/drivers/spi/spi-mux.c
+++ b/drivers/spi/spi-mux.c
@@ -86,7 +86,13 @@ static int spi_mux_setup(struct spi_device *spi)
 	 * can be called multiple times, won't do a valid setup now but we will
 	 * change the settings when we do a transfer (necessary because we
 	 * can't predict from which device it will be anyway)
+	 *
+	 * The child may have changed its settings, so make the next transfer
+	 * copy them again even if this child is the current one. This runs
+	 * under our io_mutex, so no message is being forwarded right now.
 	 */
+	priv->current_cs = SPI_MUX_NO_CS;
+
 	return spi_setup(priv->spi);
 }
 
-- 
2.56.0.317.g454f8302e1-goog

