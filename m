Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794413293;
	b=T7yfr8YDSHGseb1M50n2I6zIV53gR7FngAkt4Xen/GLo+e8k/hbMXW/xmTJQmuD9qMQP
	 UeCoeebYIJoMESwuRSU1021LYNarWqhWcwF58VmwvcdqouwFA5tF4uNQllNJ9NqiXiVUS
	 5phV3kxmdPEaXTvosnQBdNdUdh4vkybkKlmYrKRTpt4xjwB5F5yLo6ID+fjZNaUq3s6HZ
	 dlCzBV7WR5pEjGOogkTDzok4mYYRLiha1zXrurOEZabf1PAc8Nap3phbJxeaEYBraJszX
	 54gEMp1BuJHtebHTiNX8rNTaK8zkZudSfKPxS7QJWosiY/SNshYm9LZZYjLBbXuvAbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794413293;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cwHjInAIvZPLtLJ/IjwDiAKvIGph8Fzj2DjbdfXHpDw=;
	b=JypIq1+VUVKXBns+ZAiDdin33wHIT7x+HFo4+lwG3mAcevmUGnZbLTXyoj2mTJFlShEQ
	 ndatlnqnd+N95vxDUPi92DCTVVsBI6kJE/c4qc1dRON/zsvQlR105OGtalGh17OlC8E/p
	 FZ4C94SpLjhsnqhYZ7v9ggXTPCcNBhx7coWPB1S3sfCVqTZh8mVYaTTOPc0vKjnVw8nmc
	 zybPkm0xvmigzM5lAIcnuRm3pgS0kdbWmyWxtIDM7pW3aectj5dt8GURPw8rjJ4k7w+uM
	 2r8dckjHLV3wdLsrIxkqhbtllXG+KzJOgDizQ4Nhljs15m2ikXQJfUMNOwH0wRjFlAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jr3Cgi8t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8466606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jr3Cgi8t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13651F00A07;
	Wed, 11 Nov 2026 16:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794413293;
	bh=cwHjInAIvZPLtLJ/IjwDiAKvIGph8Fzj2DjbdfXHpDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jr3Cgi8tz1jUSmyhKa97yA79Q//3jqxgY14WLPL0lqIM1DHG4TaJKY2Qsl+5JWb4K
	 k33tUjkt8X5gr6++IO7hUPjxg4gLycn2w+WvE/t4WHdkQw83ZIjTf0iAqKHvBysxGs
	 pISN6L9KXwy7YOKvji4qYdU/JLyuH/25I3E38+S+Hrl0RkdiowyODDv4xNsv5Rp+1E
	 Hw+/VLotduD4yZ3htjVX09e/X9DSOY+x8XBHIJlgxQUiW+Yt8vqZISknRI2D1w4GE0
	 rFilI5X2Hj5nQMXggWbNVZcqtz3aTj1y9McIqMsOyKRZRGHosUilxrFJnb2nviEUYw
	 9wfyeyHYFtauA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ACPI: APEI: accumulate the queued flag across error sections
Date: Wed, 11 Nov 2026 11:08:11 -0500
Message-ID: <20261111160759.3147825-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053337-failed-6.6-f341307a1489@kernel.org>
References: <20261107053337-failed-6.6-f341307a1489@kernel.org>
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

From: Breno Leitao <leitao@debian.org>

[ Upstream commit f341307a14895e5da056fb419a31ef7fb534ab18 ]

ghes_do_proc() walks every error section of a CPER record, and
ghes_handle_arm_hw_error() walks every error-info entry of an ARM
processor section.  Both assign to "queued" instead of OR-ing into it,
so only the last iteration counts: a later section or entry that queues
no memory-failure work clears the flag an earlier one set.

Instead of reassigning the variable at every time, just do an `OR`, so,
if there was a single match, it will return "queued" as set.

The comment above the check says "If no memory failure
work is queued", which is the semantics this patch implements. I.e, only
SIGBUS if there are queue was not handled at all. If we want to SIGBUS
if any event was not handled/queued at all, we will need something more
sophisticated.

Fixes: 7f17b4a121d0 ("ACPI: APEI: Kick the memory_failure() queue for synchronous errors")
Fixes: ccb5ecdc2dde ("ACPI: APEI: fix synchronous external aborts in user-mode")
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Link: https://patch.msgid.link/20260925-ghes-queued-accumulate-v1-1-df50553957d4@debian.org
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
[ sashal: adjusted ghes_do_proc() context for the older else if chain without CXL handlers ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/acpi/apei/ghes.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 36917a7613d06..fd491c5476dfe 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -557,7 +557,7 @@ static bool ghes_handle_arm_hw_error(struct acpi_hest_generic_data *gdata,
 		 * and don't filter out 'corrected' error here.
 		 */
 		if (is_cache && has_pa) {
-			queued = ghes_do_memory_failure(err_info->physical_fault_addr, flags);
+			queued |= ghes_do_memory_failure(err_info->physical_fault_addr, flags);
 			p += err_info->length;
 			continue;
 		}
@@ -706,13 +706,13 @@ static bool ghes_do_proc(struct ghes *ghes,
 			atomic_notifier_call_chain(&ghes_report_chain, sev, mem_err);
 
 			arch_apei_report_mem_error(sev, mem_err);
-			queued = ghes_handle_memory_failure(gdata, sev, sync);
+			queued |= ghes_handle_memory_failure(gdata, sev, sync);
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
 			ghes_handle_aer(gdata);
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
-			queued = ghes_handle_arm_hw_error(gdata, sev, sync);
+			queued |= ghes_handle_arm_hw_error(gdata, sev, sync);
 		} else {
 			void *err = acpi_hest_get_payload(gdata);
 
-- 
2.53.0

