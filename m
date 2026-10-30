Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793357508;
	b=CNjlqyLhz+zmp5Wany8zfUTfQetksV6XvztnRUUCAmINuA8QQiX9xWPqIhDu8t8EW2oO
	 1ONQKZcdy1mJQQTj9GVCVb3k91PPZk4D4PuRoOsBaOjV5IcDAg4jr8ihVCMeuIcyOZH5Y
	 OJUnyUb08TD1Wf7cnPp/hDuR2pr6WfwZq9AKzVp6XCBYrS68D3u8KTmMsFSmhgXJlR2GH
	 8biFDjvwFEKPsgoS86sZk3qBAYKXZVbDZBNMukFuSyPz0NkkyplxBXKQP+2SumcWx/fS3
	 9FACCk51eEgZFZb/ViwROZ65/pfS0QAMltQJqDB2UzoVt3PfyzJxUSJWQwVLPXcZMjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793357508;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dY3TW4gVyH389BRWJY/TpocEjcncyQkeiLAGfm7WDB0=;
	b=ahwJ+KiviAsWJvI272srif8GCF2DzwjkjJ4b0aFAVqzrNkuTNtB0XaWsQVIdLtUO1d4c
	 oiJEbaf9FOsVD2K0WP73iA3e4oVC+zFUzFoekS3gz3waeZnZ32JsGZGktP/ww7/QTZ3i1
	 yPBP3HG5yofK8Mvnt1i58sjxodghVz/qm0wICu6qBGzThHl+GqM5UdiqGNZCYExyOY0I4
	 0s3NQkeziKYjoEO+AgxmngvCybTy3XU6boGJmNM9WwJ6Id9O/eT0+dfnTKw3Iug97mmY1
	 xr6Cpu99uXlr6BQABzI47YRJK7VCy5gd6ICq0RzyfTL2ki6baBZzVj9kE8XQXKpgtTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gDlSCkg1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E00606A337;
	Fri, 30 Oct 2026 10:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gDlSCkg1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BFED1F00A16;
	Fri, 30 Oct 2026 10:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793357507;
	bh=dY3TW4gVyH389BRWJY/TpocEjcncyQkeiLAGfm7WDB0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gDlSCkg1nc3GvBuCEqjdT+mWhwEk3my50hDU/dGynPxHevpRA2oU9rkxBJvSP5SHd
	 +Ygm080yHJuu4TbaX5B0sgljmOayndSJbw+q0Tugj6yCroJJ+deEtSG/ndkzKibqFm
	 ixU991KKQG1an356pnhyx7OUbeNVpEiDDqMVYMYjkG5UnvPLWQ3i5D+3KO2OFoYG3a
	 jYDr09BooKyPdobXbHhgv4hFXwriVoQYXLHF4E3wrHGPjqt6c3PN0l5hFAOhbcQI/W
	 JmcH77WjXsGdvVpHEK/1KSOC/V8D4xB4NBeT1WVwwNuxGXL17MrIg62s/lsQFkBLDs
	 0lEY6vm0n2NiA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 13/21] soundwire: amd: Check ping command response for timeout
Date: Fri, 30 Oct 2026 10:46:52 +0000
Message-ID: <20261030104840.3361217-14-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
In-Reply-To: <20261030104840.3361217-1-lee@kernel.org>
References: <20261030104840.3361217-1-lee@kernel.org>
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

When amd_sdw_send_cmd_get_resp() times out, it returns -ETIMEDOUT as a
sign-extended 64-bit value.  amd_sdw_read_and_process_ping_status() and
amd_sdw_read_ping_status() extract peripheral status bits directly from
the returned value without checking for -ETIMEDOUT, interpreting the
error code bits as peripheral status values.

Check for -ETIMEDOUT before extracting peripheral status from the ping
response, matching amd_program_scp_addr() and amd_sdw_fill_msg_resp().

Fixes: d8f48fbdfd9a ("soundwire: amd: Add support for AMD Manager driver")
Closes: https://sashiko.dev/#/bug/linux-c3a53ed5-eb8f-4982-a3b6-db189e009b68
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/soundwire/amd_manager.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
index a3316efdf8ac..a8220235a2ae 100644
--- a/drivers/soundwire/amd_manager.c
+++ b/drivers/soundwire/amd_manager.c
@@ -448,6 +448,8 @@ static void amd_sdw_read_and_process_ping_status(struct amd_sdw_manager *amd_man
 	mutex_lock(&amd_manager->bus.msg_lock);
 	response = amd_sdw_send_cmd_get_resp(amd_manager, 0, 0);
 	mutex_unlock(&amd_manager->bus.msg_lock);
+	if (response == -ETIMEDOUT)
+		return;
 	amd_sdw_process_ping_status(response, amd_manager);
 }
 
@@ -458,6 +460,8 @@ static u32 amd_sdw_read_ping_status(struct sdw_bus *bus)
 	u32 slave_stat;
 
 	response = amd_sdw_send_cmd_get_resp(amd_manager, 0, 0);
+	if (response == -ETIMEDOUT)
+		return 0;
 	/* slave status from ping response */
 	slave_stat = FIELD_GET(AMD_SDW_MCP_SLAVE_STAT_0_3, response);
 	slave_stat |= FIELD_GET(AMD_SDW_MCP_SLAVE_STAT_4_11, response) << 8;
-- 
2.56.0.317.g454f8302e1-goog

